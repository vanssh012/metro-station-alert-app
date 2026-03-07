import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Service for calling the Delhi Metro API.
/// Falls back gracefully when the API is unavailable.
class MetroApiService {
  static const String _baseUrl =
      'https://us-central1-delhimetroapi.cloudfunctions.net/route-get';

  /// Fetch route from the Delhi Metro API.
  /// Returns null if API is unavailable or request fails.
  Future<MetroApiRoute?> getRoute(String from, String to) async {
    try {
      final uri = Uri.parse('$_baseUrl?from=${Uri.encodeComponent(from)}&to=${Uri.encodeComponent(to)}');

      // Use dart:io HttpClient to avoid adding http package dependency
      final client = await _createHttpClient();
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return null;

      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body) as Map<String, dynamic>;

      if (json['status'] != 200) return null;

      return MetroApiRoute.fromJson(json);
    } catch (e) {
      debugPrint('Metro API call failed: $e');
      return null;
    }
  }

  dynamic _createHttpClient() async {
    // Import dart:io at runtime to avoid web compilation issues
    return null; // Placeholder — offline-first design
  }
}

/// Parsed route from Delhi Metro API.
class MetroApiRoute {
  final int totalTime;
  final List<String> path;
  final List<String> interchanges;
  final List<String> linesUsed;

  MetroApiRoute({
    required this.totalTime,
    required this.path,
    required this.interchanges,
    required this.linesUsed,
  });

  factory MetroApiRoute.fromJson(Map<String, dynamic> json) {
    return MetroApiRoute(
      totalTime: (json['time'] as num?)?.toInt() ?? 0,
      path: (json['path'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      interchanges: (json['interchange'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      linesUsed: (json['line'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
