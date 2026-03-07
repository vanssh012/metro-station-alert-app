import 'station.dart';

/// Represents a segment of a journey on a single metro line.
class JourneyLeg {
  final String lineId;
  final String lineName;
  final String lineColor;
  final List<Station> stations;
  final String direction; // Terminal station name (direction of travel)

  const JourneyLeg({
    required this.lineId,
    required this.lineName,
    required this.lineColor,
    required this.stations,
    required this.direction,
  });

  Station get startStation => stations.first;
  Station get endStation => stations.last;
  int get stationCount => stations.length;
}

/// Represents an interchange between two journey legs.
class Interchange {
  final Station station;
  final String fromLine;
  final String fromLineColor;
  final String toLine;
  final String toLineColor;
  final String direction; // Direction to travel on the new line

  const Interchange({
    required this.station,
    required this.fromLine,
    required this.fromLineColor,
    required this.toLine,
    required this.toLineColor,
    required this.direction,
  });

  String get instruction =>
      'Change at ${station.name} to $toLine towards $direction';
}

/// Represents a complete journey from start to destination.
class Journey {
  final Station startStation;
  final Station endStation;
  final List<JourneyLeg> legs;
  final List<Interchange> interchanges;
  final List<Station> allStations; // Flat list of all stations in order
  final int totalStations;
  final bool isDirect;
  final int totalTimeMinutes; // Computed from per-line avg times + interchange time

  const Journey({
    required this.startStation,
    required this.endStation,
    required this.legs,
    required this.interchanges,
    required this.allStations,
    required this.totalStations,
    required this.isDirect,
    this.totalTimeMinutes = 0,
  });

  /// Estimated journey time in minutes
  int get estimatedTimeMinutes => totalTimeMinutes > 0 ? totalTimeMinutes : (totalStations * 2.5).round();
}

/// Status of an active journey.
enum JourneyStatus {
  idle,
  active,
  approachingInterchange,
  approachingDestination,
  arrived,
  completed,
}
