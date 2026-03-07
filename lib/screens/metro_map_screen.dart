import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../data/metro_data_provider.dart';
import '../models/station.dart';
import '../models/metro_line.dart';
import '../services/journey_provider.dart';

class MetroMapScreen extends StatefulWidget {
  const MetroMapScreen({super.key});

  @override
  State<MetroMapScreen> createState() => _MetroMapScreenState();
}

class _MetroMapScreenState extends State<MetroMapScreen> {
  final TransformationController _transformController = TransformationController();
  Station? _selectedStation;
  String? _selectedLineFilter;

  @override
  void initState() {
    super.initState();
    // Start slightly zoomed out to show the full network
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _transformController.value = Matrix4.identity()
        ..translate(50.0, 100.0, 0.0)
        ..scale(0.85, 0.85, 1.0);
    });
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<MetroDataProvider>();
    final lines = dataProvider.lines;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metro Map'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.center_focus_strong_rounded),
            onPressed: () {
              _transformController.value = Matrix4.identity()
                ..translate(50.0, 100.0, 0.0)
                ..scale(0.85, 0.85, 1.0);
            },
            tooltip: 'Reset view',
          ),
        ],
      ),
      body: Column(
        children: [
          // Line filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              children: [
                _buildLineFilterChip(null, 'All Lines', AppTheme.accent),
                const SizedBox(width: 6),
                ...lines.map((line) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _buildLineFilterChip(line.id, line.name, line.color),
                )),
              ],
            ),
          ),
          // Map area
          Expanded(
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController: _transformController,
                  boundaryMargin: const EdgeInsets.all(200),
                  minScale: 0.3,
                  maxScale: 4.0,
                  child: SizedBox(
                    width: 1200,
                    height: 1600,
                    child: CustomPaint(
                      painter: MetroMapPainter(
                        dataProvider: dataProvider,
                        selectedStation: _selectedStation,
                        selectedLineFilter: _selectedLineFilter,
                      ),
                      child: GestureDetector(
                        onTapDown: (details) => _onMapTap(details, dataProvider),
                      ),
                    ),
                  ),
                ),
                // Selected station info card
                if (_selectedStation != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildStationInfoCard(context),
                  ),
                // Legend
                if (_selectedStation == null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: _buildLegend(lines),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineFilterChip(String? lineId, String name, Color color) {
    final isSelected = _selectedLineFilter == lineId;
    return GestureDetector(
      onTap: () => setState(() => _selectedLineFilter = lineId),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : AppTheme.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? color : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  void _onMapTap(TapDownDetails details, MetroDataProvider dataProvider) {
    final matrix = _transformController.value;
    final inverseMatrix = Matrix4.inverted(matrix);
    final tapPos = MatrixUtils.transformPoint(
      inverseMatrix,
      details.localPosition,
    );

    // Find closest station within threshold
    Station? closest;
    double closestDist = 20.0; // tap threshold in map pixels

    for (final station in dataProvider.stations) {
      final pos = _latLonToMapPoint(station.latitude, station.longitude);
      final dist = (Offset(pos.dx, pos.dy) - Offset(tapPos.dx, tapPos.dy)).distance;
      if (dist < closestDist) {
        closestDist = dist;
        closest = station;
      }
    }

    setState(() => _selectedStation = closest);
  }

  static Offset _latLonToMapPoint(double lat, double lon) {
    // Map coordinate transform: lat/lon → screen pixels
    // Delhi Metro spans roughly lat 28.38-28.99, lon 76.96-77.70
    const minLat = 28.35;
    const maxLat = 29.00;
    const minLon = 76.92;
    const maxLon = 77.72;

    const mapWidth = 1200.0;
    const mapHeight = 1600.0;
    const padding = 60.0;

    final x = padding + ((lon - minLon) / (maxLon - minLon)) * (mapWidth - 2 * padding);
    final y = padding + ((maxLat - lat) / (maxLat - minLat)) * (mapHeight - 2 * padding);
    return Offset(x, y);
  }

  Widget _buildStationInfoCard(BuildContext context) {
    final station = _selectedStation!;
    final lineColor = AppTheme.getLineColor(station.lineColor);
    final journeyProvider = context.read<JourneyProvider>();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: lineColor, width: 3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 14, height: 14,
                  decoration: BoxDecoration(color: lineColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    station.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppTheme.textMuted),
                  onPressed: () => setState(() => _selectedStation = null),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: lineColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(station.lineName, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: lineColor)),
                ),
                const SizedBox(width: 8),
                Text(station.network, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                if (station.isInterchange) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.warning.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('⇔ Interchange', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.warning)),
                  ),
                ],
              ],
            ),
            if (station.nameHindi.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(station.nameHindi, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
            ],
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      journeyProvider.setStartStation(station);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.my_location_rounded, size: 16),
                    label: const Text('Set Start', style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.success,
                      foregroundColor: AppTheme.primaryDark,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      journeyProvider.setEndStation(station);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.location_on_rounded, size: 16),
                    label: const Text('Set Dest', style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.danger,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(List<MetroLine> lines) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metro Lines', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: lines.map((line) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14, height: 4,
                  decoration: BoxDecoration(color: line.color, borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(width: 4),
                Text(
                  line.name,
                  style: TextStyle(fontSize: 9, color: line.color, fontWeight: FontWeight.w500),
                ),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter that draws the metro network map.
class MetroMapPainter extends CustomPainter {
  final MetroDataProvider dataProvider;
  final Station? selectedStation;
  final String? selectedLineFilter;

  MetroMapPainter({
    required this.dataProvider,
    this.selectedStation,
    this.selectedLineFilter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background grid
    _drawBackground(canvas, size);

    // Draw each metro line
    for (final line in dataProvider.lines) {
      final isFiltered = selectedLineFilter != null && selectedLineFilter != line.id;
      _drawLine(canvas, line, isFiltered ? 0.12 : 1.0);
    }

    // Draw all stations
    for (final line in dataProvider.lines) {
      final isFiltered = selectedLineFilter != null && selectedLineFilter != line.id;
      final stations = dataProvider.getStationsForLine(line.id);
      for (int i = 0; i < stations.length; i++) {
        _drawStation(canvas, stations[i], line, i == 0 || i == stations.length - 1, isFiltered ? 0.12 : 1.0);
      }
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    // Subtle grid
    final gridPaint = Paint()
      ..color = AppTheme.divider.withOpacity(0.1)
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawLine(Canvas canvas, MetroLine line, double opacity) {
    final stations = dataProvider.getStationsForLine(line.id);
    if (stations.length < 2) return;

    final paint = Paint()
      ..color = line.color.withOpacity(opacity)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw glow effect
    if (opacity > 0.5) {
      final glowPaint = Paint()
        ..color = line.color.withOpacity(0.15)
        ..strokeWidth = 12.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final glowPath = Path();
      final firstPos = _latLonToMapPoint(stations[0].latitude, stations[0].longitude);
      glowPath.moveTo(firstPos.dx, firstPos.dy);
      for (int i = 1; i < stations.length; i++) {
        final pos = _latLonToMapPoint(stations[i].latitude, stations[i].longitude);
        glowPath.lineTo(pos.dx, pos.dy);
      }
      canvas.drawPath(glowPath, glowPaint);
    }

    final path = Path();
    final firstPos = _latLonToMapPoint(stations[0].latitude, stations[0].longitude);
    path.moveTo(firstPos.dx, firstPos.dy);
    for (int i = 1; i < stations.length; i++) {
      final pos = _latLonToMapPoint(stations[i].latitude, stations[i].longitude);
      path.lineTo(pos.dx, pos.dy);
    }
    canvas.drawPath(path, paint);
  }

  void _drawStation(Canvas canvas, Station station, MetroLine line, bool isTerminal, double opacity) {
    final pos = _latLonToMapPoint(station.latitude, station.longitude);
    final color = line.color.withOpacity(opacity);

    if (station.isInterchange) {
      // Interchange: white circle with colored border
      final outerPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      final innerPaint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 8, outerPaint);
      canvas.drawCircle(pos, 5, innerPaint);
    } else if (isTerminal) {
      // Terminal: large colored dot
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 7, paint);
      final borderPaint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(pos, 7, borderPaint);
    } else {
      // Regular: small colored dot
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 3.5, paint);
    }

    final isSelected = selectedStation?.id == station.id;

    // Draw selected station highlight
    if (isSelected) {
      final highlightPaint = Paint()
        ..color = AppTheme.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawCircle(pos, 12, highlightPaint);
    }

    // Show label for interchange, terminal, or selected stations
    if ((station.isInterchange || isTerminal || isSelected) && opacity > 0.5) {
      _drawLabel(canvas, station.name, pos, color, isSelected);
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color, bool isSelected) {
    final textStyle = TextStyle(
      color: isSelected ? AppTheme.accent : Colors.white,
      fontSize: isSelected ? 11 : 9,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      shadows: [
        Shadow(color: Colors.black.withOpacity(0.8), blurRadius: 3, offset: const Offset(1, 1)),
        Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 6),
      ],
    );

    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 120);

    // Draw background for readability
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        pos.dx + 10,
        pos.dy - textPainter.height / 2 - 2,
        textPainter.width + 8,
        textPainter.height + 4,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      bgRect,
      Paint()..color = AppTheme.cardDark.withOpacity(0.85),
    );

    textPainter.paint(canvas, Offset(pos.dx + 14, pos.dy - textPainter.height / 2));
  }

  static Offset _latLonToMapPoint(double lat, double lon) {
    const minLat = 28.35;
    const maxLat = 29.00;
    const minLon = 76.92;
    const maxLon = 77.72;

    const mapWidth = 1200.0;
    const mapHeight = 1600.0;
    const padding = 60.0;

    final x = padding + ((lon - minLon) / (maxLon - minLon)) * (mapWidth - 2 * padding);
    final y = padding + ((maxLat - lat) / (maxLat - minLat)) * (mapHeight - 2 * padding);
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant MetroMapPainter oldDelegate) {
    return oldDelegate.selectedStation != selectedStation ||
        oldDelegate.selectedLineFilter != selectedLineFilter;
  }
}
