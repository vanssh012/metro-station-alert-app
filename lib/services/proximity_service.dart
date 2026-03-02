import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/station.dart';
import '../utils/haversine.dart';
import '../utils/constants.dart';
import 'journey_provider.dart';

/// Callback types for proximity events.
typedef ProximityCallback = void Function(Station station, double distance);

/// GPS-based proximity detection for station tracking.
/// In production, this would use Geolocator for real GPS.
/// For MVP demo, it can be driven manually or with simulated data.
class ProximityService {
  final JourneyProvider _journeyProvider;
  Timer? _pollingTimer;
  bool _isTracking = false;

  ProximityCallback? onApproachingStation;
  ProximityCallback? onApproachingInterchange;
  ProximityCallback? onApproachingDestination;
  VoidCallback? onStationPassed;

  ProximityService(this._journeyProvider);

  bool get isTracking => _isTracking;

  /// Start tracking the journey using GPS polling.
  void startTracking() {
    if (_isTracking) return;
    _isTracking = true;

    _pollingTimer = Timer.periodic(
      Duration(seconds: AppConstants.gpsPollingIntervalSeconds),
      (_) => _checkProximity(),
    );
  }

  /// Stop tracking.
  void stopTracking() {
    _isTracking = false;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Process a GPS location update. 
  /// Call this from the GPS service or for manual testing.
  void processLocationUpdate(double lat, double lon) {
    final journey = _journeyProvider.currentJourney;
    if (journey == null) return;

    final currentIdx = _journeyProvider.currentStationIndex;
    final stations = journey.allStations;
    if (currentIdx >= stations.length) return;

    // Check distance to next station
    final nextIdx = currentIdx + 1;
    if (nextIdx >= stations.length) return;

    final nextStation = stations[nextIdx];
    final distance = Haversine.distanceInMeters(
      lat, lon, nextStation.latitude, nextStation.longitude,
    );

    _journeyProvider.updateLocation(lat, lon, distance);

    // Check if we've passed the current station
    if (distance < AppConstants.stationPassedDistance) {
      _journeyProvider.advanceToNextStation();
      onStationPassed?.call();
    }

    // Check if approaching destination (next station is destination)
    if (nextStation.id == journey.endStation.id &&
        distance < AppConstants.destinationAlertDistance) {
      _journeyProvider.setApproachingDestination();
      onApproachingDestination?.call(nextStation, distance);
    }

    // Check if approaching interchange
    final nextInterchange = _journeyProvider.nextInterchange;
    if (nextInterchange != null &&
        nextStation.name == nextInterchange.name &&
        distance < AppConstants.interchangeAlertDistance) {
      _journeyProvider.setApproachingInterchange();
      onApproachingInterchange?.call(nextStation, distance);
    }
  }

  /// Simulate checking proximity (placeholder for real GPS).
  void _checkProximity() {
    // In production, get real GPS coordinates here:
    // final position = await Geolocator.getCurrentPosition();
    // processLocationUpdate(position.latitude, position.longitude);
    
    // For now, this is a no-op. GPS integration happens in production build.
    debugPrint('ProximityService: polling for GPS update...');
  }

  void dispose() {
    stopTracking();
  }
}
