import 'package:flutter/foundation.dart';

/// Alert types and intensities.
enum AlertType { destination, interchange, warning }
enum AlertIntensity { normal, high, maximum }

/// Manages multi-modal alerts (vibration, sound, notification).
/// In production, integrates with flutter_local_notifications,
/// vibration, and audioplayers packages.
class AlertService {
  bool _isSleepMode = false;
  AlertIntensity _currentIntensity = AlertIntensity.normal;

  bool get isSleepMode => _isSleepMode;
  AlertIntensity get currentIntensity => _currentIntensity;

  void setSleepMode(bool enabled) {
    _isSleepMode = enabled;
  }

  /// Trigger a destination alert.
  Future<void> triggerDestinationAlert(String stationName) async {
    debugPrint('🔔 ALERT: Approaching destination - $stationName');
    _currentIntensity = _isSleepMode ? AlertIntensity.maximum : AlertIntensity.normal;
    await _triggerAlert(
      title: 'Approaching Destination!',
      body: 'Next station: $stationName\nPrepare to get down.',
      type: AlertType.destination,
    );
  }

  /// Trigger an interchange alert.
  Future<void> triggerInterchangeAlert({
    required String stationName,
    required String toLine,
    required String direction,
  }) async {
    debugPrint('🔄 ALERT: Interchange at $stationName → $toLine');
    _currentIntensity = AlertIntensity.normal;
    await _triggerAlert(
      title: 'Interchange Coming Up!',
      body: 'Change at $stationName\nSwitch to $toLine\nDirection: $direction',
      type: AlertType.interchange,
    );
  }

  /// Escalate alert intensity (if user hasn't acknowledged).
  Future<void> escalateAlert() async {
    switch (_currentIntensity) {
      case AlertIntensity.normal:
        _currentIntensity = AlertIntensity.high;
        break;
      case AlertIntensity.high:
      case AlertIntensity.maximum:
        _currentIntensity = AlertIntensity.maximum;
        break;
    }
    debugPrint('⚠️ Alert escalated to $_currentIntensity');
    // In production: increase vibration duration, volume, etc.
  }

  /// Dismiss the current alert.
  void dismissAlert() {
    _currentIntensity = AlertIntensity.normal;
    // In production: stop vibration, sound, dismiss notification
  }

  /// Core alert trigger — in production, this calls platform APIs.
  Future<void> _triggerAlert({
    required String title,
    required String body,
    required AlertType type,
  }) async {
    // Production implementation:
    // 1. flutter_local_notifications → show notification
    // 2. vibration → vibrate with pattern based on intensity
    // 3. audioplayers → play alert sound
    // 4. If sleep mode → override silent mode, max volume

    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('ALERT [$type] (Intensity: $_currentIntensity)');
    debugPrint('Title: $title');
    debugPrint('Body: $body');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}
