/// App-wide constants for MetroWake.

class AppConstants {
  // Proximity thresholds (meters)
  static const double destinationAlertDistance = 500.0;
  static const double interchangeAlertDistance = 700.0;
  static const double stationPassedDistance = 300.0;

  // GPS polling interval
  static const int gpsPollingIntervalSeconds = 5;

  // Alert escalation timing
  static const int firstAlertDelaySeconds = 0;
  static const int secondAlertDelaySeconds = 10;
  static const int maxAlertDelaySeconds = 30;

  // Journey estimation
  static const double avgMinutesPerStation = 2.5;

  // App info
  static const String appName = 'MetroWake';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Never miss your station again';
}

/// Metro network identifiers.
class MetroNetworks {
  static const String dmrc = 'DMRC';
  static const String ncrtc = 'NCRTC';
}

/// Metro line identifiers.
class LineIds {
  // DMRC Lines
  static const String blue = 'blue_line';
  static const String blueBranch = 'blue_branch';
  static const String yellow = 'yellow_line';
  static const String red = 'red_line';
  static const String green = 'green_line';
  static const String greenBranch = 'green_branch';
  static const String violet = 'violet_line';
  static const String pink = 'pink_line';
  static const String magenta = 'magenta_line';
  static const String orange = 'orange_line'; // Airport Express
  static const String grey = 'grey_line';
  static const String rapid = 'rapid_metro'; // Gurugram Rapid Metro

  // NCRTC Lines
  static const String rrtsMeerut = 'rrts_meerut';
}

/// Metro line colors (official).
class LineColors {
  static const String blue = '#0098D4';
  static const String yellow = '#FFCB08';
  static const String red = '#EE1C25';
  static const String green = '#00A650';
  static const String violet = '#7E4D8B';
  static const String pink = '#E91E8C';
  static const String magenta = '#BB2299';
  static const String orange = '#F68B24';
  static const String grey = '#8C8C8C';
  static const String rrtsMeerut = '#FF6B35';
}
