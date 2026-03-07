import '../models/station.dart';
import '../models/metro_line.dart';
import 'stations_blue.dart';
import 'stations_yellow.dart';
import 'stations_other.dart';
import 'stations_pink.dart';
import 'stations_extended.dart';
import 'metro_lines_data.dart';

/// Provides access to all metro station and line data.
class MetroDataProvider {
  List<Station> _stations = [];
  List<MetroLine> _lines = [];
  bool _initialized = false;

  bool get isInitialized => _initialized;
  List<Station> get stations => _stations;
  List<MetroLine> get lines => _lines;

  Future<void> initialize() async {
    if (_initialized) return;
    _stations = [
      ...blueLineStations,
      ...yellowLineStations,
      ...otherLineStations,
      ...pinkLineStations,
      ...blueBranchStations,
      ...orangeLineStations,
      ...greyLineStations,
      ...aquaLineStations,
      ...rapidMetroStations,
    ];
    _lines = allMetroLines;
    _initialized = true;
  }

  Station? getStationById(String id) {
    try {
      return _stations.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Station> searchStations(String query) {
    if (query.isEmpty) return [];
    final q = query.toLowerCase();
    return _stations
        .where((s) =>
            s.name.toLowerCase().contains(q) ||
            s.nameHindi.contains(q))
        .toList();
  }

  List<Station> getStationsForLine(String lineId) {
    return _stations.where((s) => s.lineId == lineId).toList()
      ..sort((a, b) => a.stationOrder.compareTo(b.stationOrder));
  }

  List<Station> getInterchangeStations() {
    return _stations.where((s) => s.isInterchange).toList();
  }

  MetroLine? getLineById(String lineId) {
    try {
      return _lines.firstWhere((l) => l.id == lineId);
    } catch (_) {
      return null;
    }
  }

  /// Get unique station names (for interchange stations appearing on multiple lines)
  List<Station> getUniqueStations() {
    final seen = <String>{};
    return _stations.where((s) {
      final key = '${s.name}_${s.network}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }
}
