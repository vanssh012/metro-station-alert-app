import 'package:flutter/foundation.dart';
import '../models/station.dart';
import '../models/journey.dart';
import '../data/metro_data_provider.dart';
import 'route_service.dart';

/// Central state manager for the active journey.
class JourneyProvider extends ChangeNotifier {
  final MetroDataProvider _dataProvider;
  late final RouteService _routeService;

  // Selection state
  Station? _startStation;
  Station? _endStation;

  // Journey state
  Journey? _currentJourney;
  JourneyStatus _status = JourneyStatus.idle;
  int _currentStationIndex = 0;
  Station? _nextInterchange;

  // GPS state
  double? _currentLat;
  double? _currentLon;
  double? _distanceToNextStation;

  JourneyProvider(this._dataProvider) {
    _routeService = RouteService(_dataProvider);
  }

  // Getters
  Station? get startStation => _startStation;
  Station? get endStation => _endStation;
  Journey? get currentJourney => _currentJourney;
  JourneyStatus get status => _status;
  int get currentStationIndex => _currentStationIndex;
  Station? get nextInterchange => _nextInterchange;
  double? get currentLat => _currentLat;
  double? get currentLon => _currentLon;
  double? get distanceToNextStation => _distanceToNextStation;

  Station? get currentStation {
    if (_currentJourney == null) return null;
    if (_currentStationIndex >= _currentJourney!.allStations.length) return null;
    return _currentJourney!.allStations[_currentStationIndex];
  }

  Station? get nextStation {
    if (_currentJourney == null) return null;
    final nextIdx = _currentStationIndex + 1;
    if (nextIdx >= _currentJourney!.allStations.length) return null;
    return _currentJourney!.allStations[nextIdx];
  }

  int get stationsRemaining {
    if (_currentJourney == null) return 0;
    return _currentJourney!.allStations.length - _currentStationIndex - 1;
  }

  double get journeyProgress {
    if (_currentJourney == null || _currentJourney!.allStations.length <= 1) return 0;
    return _currentStationIndex / (_currentJourney!.allStations.length - 1);
  }

  // Station selection
  void setStartStation(Station station) {
    _startStation = station;
    _currentJourney = null;
    notifyListeners();
  }

  void setEndStation(Station station) {
    _endStation = station;
    _currentJourney = null;
    notifyListeners();
  }

  void swapStations() {
    final temp = _startStation;
    _startStation = _endStation;
    _endStation = temp;
    _currentJourney = null;
    notifyListeners();
  }

  // Route planning
  Journey? planRoute() {
    if (_startStation == null || _endStation == null) return null;
    _currentJourney = _routeService.findRoute(_startStation!, _endStation!);
    notifyListeners();
    return _currentJourney;
  }

  // Journey control
  void startJourney() {
    if (_currentJourney == null) return;
    _status = JourneyStatus.active;
    _currentStationIndex = 0;
    _findNextInterchange();
    notifyListeners();
  }

  void stopJourney() {
    _status = JourneyStatus.idle;
    _currentStationIndex = 0;
    _nextInterchange = null;
    _distanceToNextStation = null;
    notifyListeners();
  }

  void completeJourney() {
    _status = JourneyStatus.completed;
    notifyListeners();
  }

  // GPS updates
  void updateLocation(double lat, double lon, double distToNext) {
    _currentLat = lat;
    _currentLon = lon;
    _distanceToNextStation = distToNext;
    notifyListeners();
  }

  void advanceToNextStation() {
    if (_currentJourney == null) return;
    _currentStationIndex++;
    if (_currentStationIndex >= _currentJourney!.allStations.length - 1) {
      _status = JourneyStatus.approachingDestination;
    }
    _findNextInterchange();
    notifyListeners();
  }

  void setApproachingInterchange() {
    _status = JourneyStatus.approachingInterchange;
    notifyListeners();
  }

  void setApproachingDestination() {
    _status = JourneyStatus.approachingDestination;
    notifyListeners();
  }

  void setArrived() {
    _status = JourneyStatus.arrived;
    notifyListeners();
  }

  void _findNextInterchange() {
    if (_currentJourney == null || _currentJourney!.interchanges.isEmpty) {
      _nextInterchange = null;
      return;
    }

    for (final ic in _currentJourney!.interchanges) {
      final icIdx = _currentJourney!.allStations.indexWhere(
        (s) => s.name == ic.station.name,
      );
      if (icIdx > _currentStationIndex) {
        _nextInterchange = ic.station;
        return;
      }
    }
    _nextInterchange = null;
  }

  // Recent journeys (simple in-memory list for MVP)
  final List<Map<String, Station>> _recentJourneys = [];
  List<Map<String, Station>> get recentJourneys => _recentJourneys;

  void addToRecent() {
    if (_startStation == null || _endStation == null) return;
    _recentJourneys.insert(0, {
      'start': _startStation!,
      'end': _endStation!,
    });
    if (_recentJourneys.length > 5) _recentJourneys.removeLast();
  }
}
