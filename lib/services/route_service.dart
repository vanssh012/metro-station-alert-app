import '../models/station.dart';
import '../models/journey.dart';
import '../models/metro_line.dart';
import '../data/metro_data_provider.dart';

/// Service for finding routes between metro stations.
/// Supports direct (same-line) and single/multi-interchange routes.
/// Computes travel time using per-line official average times.
class RouteService {
  final MetroDataProvider _dataProvider;

  /// Interchange time in minutes (walking between platforms)
  static const double interchangeTimeMinutes = 5.0;

  RouteService(this._dataProvider);

  /// Find the best route between two stations.
  Journey? findRoute(Station start, Station end) {
    // Case 1: Same line — direct route
    if (start.lineId == end.lineId) {
      return _buildDirectRoute(start, end);
    }

    // Case 2: Single interchange route
    return _buildInterchangeRoute(start, end);
  }

  /// Calculate travel time for a list of stations on a given line.
  double _calculateLegTime(List<Station> stations, String lineId) {
    final line = _dataProvider.getLineById(lineId);
    final avgTime = line?.avgMinutesPerStation ?? 2.5;
    // Time = (number of station gaps) × avg time
    return (stations.length - 1) * avgTime;
  }

  /// Build a direct route on the same line.
  Journey? _buildDirectRoute(Station start, Station end) {
    final lineStations = _dataProvider.getStationsForLine(start.lineId);
    if (lineStations.isEmpty) return null;

    final startIdx = lineStations.indexWhere((s) => s.id == start.id);
    final endIdx = lineStations.indexWhere((s) => s.id == end.id);
    if (startIdx == -1 || endIdx == -1) return null;

    final line = _dataProvider.getLineById(start.lineId);
    if (line == null) return null;

    List<Station> routeStations;
    String direction;
    if (startIdx <= endIdx) {
      routeStations = lineStations.sublist(startIdx, endIdx + 1);
      direction = line.terminal2;
    } else {
      routeStations = lineStations.sublist(endIdx, startIdx + 1).reversed.toList();
      direction = line.terminal1;
    }

    final travelTime = _calculateLegTime(routeStations, start.lineId);

    final leg = JourneyLeg(
      lineId: start.lineId,
      lineName: start.lineName,
      lineColor: start.lineColor,
      stations: routeStations,
      direction: direction,
    );

    return Journey(
      startStation: start,
      endStation: end,
      legs: [leg],
      interchanges: [],
      allStations: routeStations,
      totalStations: routeStations.length,
      isDirect: true,
      totalTimeMinutes: travelTime.round(),
    );
  }

  /// Build a route with a single interchange.
  Journey? _buildInterchangeRoute(Station start, Station end) {
    // Find interchange stations that connect start line and end line
    final startLine = _dataProvider.getLineById(start.lineId);
    final endLine = _dataProvider.getLineById(end.lineId);
    if (startLine == null || endLine == null) return null;

    // Find common interchange stations
    final startLineStations = _dataProvider.getStationsForLine(start.lineId);
    final interchangeStations = startLineStations
        .where((s) => s.isInterchange && s.connectedLineIds.contains(end.lineId))
        .toList();

    if (interchangeStations.isEmpty) {
      // Try indirect: find intermediate interchanges via BFS-like approach
      return _buildMultiInterchangeRoute(start, end);
    }

    // Pick the interchange that minimizes total time
    Journey? bestJourney;
    double bestTime = 99999;

    for (final interchange in interchangeStations) {
      // Build leg 1: start → interchange on start line
      final leg1Stations = _getStationsBetween(start, interchange, start.lineId);
      if (leg1Stations == null) continue;

      // Find the interchange station on the end line
      final endLineStations = _dataProvider.getStationsForLine(end.lineId);
      final interchangeOnEndLine = endLineStations.firstWhere(
        (s) => s.name == interchange.name,
        orElse: () => interchange,
      );

      // Build leg 2: interchange → destination on end line
      final leg2Stations = _getStationsBetween(interchangeOnEndLine, end, end.lineId);
      if (leg2Stations == null) continue;

      final leg1Time = _calculateLegTime(leg1Stations, start.lineId);
      final leg2Time = _calculateLegTime(leg2Stations, end.lineId);
      final totalTime = leg1Time + interchangeTimeMinutes + leg2Time;

      if (totalTime < bestTime) {
        bestTime = totalTime;

        final direction1 = _getDirection(start, interchange, startLine);
        final direction2 = _getDirection(interchangeOnEndLine, end, endLine);

        final leg1 = JourneyLeg(
          lineId: start.lineId, lineName: start.lineName,
          lineColor: start.lineColor, stations: leg1Stations,
          direction: direction1,
        );
        final leg2 = JourneyLeg(
          lineId: end.lineId, lineName: end.lineName,
          lineColor: end.lineColor, stations: leg2Stations,
          direction: direction2,
        );

        final interchangeInfo = Interchange(
          station: interchange,
          fromLine: start.lineName, fromLineColor: start.lineColor,
          toLine: end.lineName, toLineColor: end.lineColor,
          direction: direction2,
        );

        final allStations = [...leg1Stations, ...leg2Stations.skip(1)];

        bestJourney = Journey(
          startStation: start, endStation: end,
          legs: [leg1, leg2],
          interchanges: [interchangeInfo],
          allStations: allStations,
          totalStations: allStations.length,
          isDirect: false,
          totalTimeMinutes: totalTime.round(),
        );
      }
    }

    return bestJourney;
  }

  /// Attempt to find a route with 2 interchanges for lines not directly connected.
  Journey? _buildMultiInterchangeRoute(Station start, Station end) {
    final allLines = _dataProvider.lines;

    Journey? bestJourney;
    double bestTime = 99999;

    // Try every intermediate line
    for (final midLine in allLines) {
      if (midLine.id == start.lineId || midLine.id == end.lineId) continue;

      // Check if start line connects to midLine
      final startLineStations = _dataProvider.getStationsForLine(start.lineId);
      final interchange1Candidates = startLineStations
          .where((s) => s.isInterchange && s.connectedLineIds.contains(midLine.id))
          .toList();
      if (interchange1Candidates.isEmpty) continue;

      // Check if midLine connects to end line
      final midLineStations = _dataProvider.getStationsForLine(midLine.id);
      final interchange2Candidates = midLineStations
          .where((s) => s.isInterchange && s.connectedLineIds.contains(end.lineId))
          .toList();
      if (interchange2Candidates.isEmpty) continue;

      // Try all combinations for best time
      for (final i1 in interchange1Candidates) {
        for (final i2 in interchange2Candidates) {
          final leg1 = _getStationsBetween(start, i1, start.lineId);
          if (leg1 == null) continue;

          final i1OnMid = midLineStations.firstWhere(
            (s) => s.name == i1.name, orElse: () => i1);
          final i2OnMid = midLineStations.firstWhere(
            (s) => s.name == i2.name, orElse: () => i2);

          final leg2 = _getStationsBetween(i1OnMid, i2OnMid, midLine.id);
          if (leg2 == null) continue;

          final endLineStations = _dataProvider.getStationsForLine(end.lineId);
          final i2OnEnd = endLineStations.firstWhere(
            (s) => s.name == i2.name, orElse: () => i2);

          final leg3 = _getStationsBetween(i2OnEnd, end, end.lineId);
          if (leg3 == null) continue;

          final time1 = _calculateLegTime(leg1, start.lineId);
          final time2 = _calculateLegTime(leg2, midLine.id);
          final time3 = _calculateLegTime(leg3, end.lineId);
          final totalTime = time1 + interchangeTimeMinutes + time2 + interchangeTimeMinutes + time3;

          if (totalTime < bestTime) {
            bestTime = totalTime;

            final startLine = _dataProvider.getLineById(start.lineId)!;
            final endLine = _dataProvider.getLineById(end.lineId)!;

            final dir1 = _getDirection(start, i1, startLine);
            final dir2 = _getDirection(i1OnMid, i2OnMid, midLine);
            final dir3 = _getDirection(i2OnEnd, end, endLine);

            final allStations = [...leg1, ...leg2.skip(1), ...leg3.skip(1)];

            bestJourney = Journey(
              startStation: start, endStation: end,
              legs: [
                JourneyLeg(lineId: start.lineId, lineName: start.lineName, lineColor: start.lineColor, stations: leg1, direction: dir1),
                JourneyLeg(lineId: midLine.id, lineName: midLine.name, lineColor: midLine.colorHex, stations: leg2, direction: dir2),
                JourneyLeg(lineId: end.lineId, lineName: end.lineName, lineColor: end.lineColor, stations: leg3, direction: dir3),
              ],
              interchanges: [
                Interchange(station: i1, fromLine: start.lineName, fromLineColor: start.lineColor, toLine: midLine.name, toLineColor: midLine.colorHex, direction: dir2),
                Interchange(station: i2, fromLine: midLine.name, fromLineColor: midLine.colorHex, toLine: end.lineName, toLineColor: end.lineColor, direction: dir3),
              ],
              allStations: allStations,
              totalStations: allStations.length,
              isDirect: false,
              totalTimeMinutes: totalTime.round(),
            );
          }
        }
      }
    }

    return bestJourney;
  }

  /// Get stations between two stations on the same line.
  List<Station>? _getStationsBetween(Station a, Station b, String lineId) {
    final lineStations = _dataProvider.getStationsForLine(lineId);
    final idxA = lineStations.indexWhere((s) => s.id == a.id);
    final idxB = lineStations.indexWhere((s) => s.id == b.id);
    if (idxA == -1 || idxB == -1) return null;

    if (idxA <= idxB) {
      return lineStations.sublist(idxA, idxB + 1);
    } else {
      return lineStations.sublist(idxB, idxA + 1).reversed.toList();
    }
  }

  /// Determine the direction of travel on a line.
  String _getDirection(Station from, Station to, MetroLine line) {
    final lineStations = _dataProvider.getStationsForLine(line.id);
    final fromIdx = lineStations.indexWhere((s) => s.id == from.id);
    final toIdx = lineStations.indexWhere((s) => s.id == to.id);
    return toIdx >= fromIdx ? line.terminal2 : line.terminal1;
  }
}
