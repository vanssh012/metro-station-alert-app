import 'package:equatable/equatable.dart';

/// Represents a metro station with its location and metadata.
class Station extends Equatable {
  final String id;
  final String name;
  final String nameHindi;
  final String network; // "DMRC" or "NCRTC"
  final String lineId;
  final String lineName;
  final String lineColor; // Hex color string
  final double latitude;
  final double longitude;
  final bool isInterchange;
  final List<String> connectedLineIds;
  final int stationOrder;
  final String locationType; // "elevated", "underground", "at-grade"

  const Station({
    required this.id,
    required this.name,
    this.nameHindi = '',
    required this.network,
    required this.lineId,
    required this.lineName,
    required this.lineColor,
    required this.latitude,
    required this.longitude,
    this.isInterchange = false,
    this.connectedLineIds = const [],
    required this.stationOrder,
    this.locationType = 'elevated',
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as String,
      name: json['name'] as String,
      nameHindi: json['name_hindi'] as String? ?? '',
      network: json['network'] as String,
      lineId: json['line_id'] as String,
      lineName: json['line_name'] as String,
      lineColor: json['line_color'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isInterchange: json['is_interchange'] as bool? ?? false,
      connectedLineIds: (json['connected_line_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      stationOrder: json['station_order'] as int,
      locationType: json['location_type'] as String? ?? 'elevated',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_hindi': nameHindi,
        'network': network,
        'line_id': lineId,
        'line_name': lineName,
        'line_color': lineColor,
        'latitude': latitude,
        'longitude': longitude,
        'is_interchange': isInterchange,
        'connected_line_ids': connectedLineIds,
        'station_order': stationOrder,
        'location_type': locationType,
      };

  @override
  List<Object?> get props => [id, lineId];

  @override
  String toString() => 'Station($name, $lineName)';
}
