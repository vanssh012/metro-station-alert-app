import 'package:flutter/material.dart';

/// Represents a metro line (e.g., Blue Line, Yellow Line).
class MetroLine {
  final String id;
  final String name;
  final String colorHex;
  final String network; // "DMRC" or "NCRTC"
  final List<String> stationIds;
  final String terminal1;
  final String terminal2;
  final double avgMinutesPerStation; // Official avg time between stations

  const MetroLine({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.network,
    required this.stationIds,
    required this.terminal1,
    required this.terminal2,
    this.avgMinutesPerStation = 2.5,
  });

  Color get color => Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

  factory MetroLine.fromJson(Map<String, dynamic> json) {
    return MetroLine(
      id: json['id'] as String,
      name: json['name'] as String,
      colorHex: json['color'] as String,
      network: json['network'] as String,
      stationIds: (json['station_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      terminal1: json['terminal_1'] as String,
      terminal2: json['terminal_2'] as String,
      avgMinutesPerStation: (json['avg_minutes_per_station'] as num?)?.toDouble() ?? 2.5,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': colorHex,
        'network': network,
        'station_ids': stationIds,
        'terminal_1': terminal1,
        'terminal_2': terminal2,
        'avg_minutes_per_station': avgMinutesPerStation,
      };

  @override
  String toString() => 'MetroLine($name)';
}
