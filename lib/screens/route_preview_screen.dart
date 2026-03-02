import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/journey_provider.dart';
import '../models/journey.dart';
import 'active_journey_screen.dart';

class RoutePreviewScreen extends StatelessWidget {
  const RoutePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JourneyProvider>(
      builder: (context, provider, _) {
        final journey = provider.currentJourney;
        if (journey == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Route Preview')),
            body: const Center(child: Text('No route available')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Route Preview'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              // Route summary card
              _buildSummaryCard(journey),
              const SizedBox(height: 8),
              // Interchange info
              if (journey.interchanges.isNotEmpty)
                _buildInterchangeCards(journey),
              // Station list
              Expanded(child: _buildStationList(journey)),
              // Start journey button
              _buildStartButton(context, provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(Journey journey) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.surfaceDark, AppTheme.cardDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          _summaryItem(Icons.train_rounded, '${journey.totalStations}', 'Stations', AppTheme.accent),
          _dividerDot(),
          _summaryItem(Icons.timer_rounded, '~${journey.estimatedTimeMinutes}', 'Minutes', AppTheme.yellowLineColor),
          _dividerDot(),
          _summaryItem(Icons.swap_calls_rounded, '${journey.interchanges.length}', 'Changes', AppTheme.pinkLineColor),
          _dividerDot(),
          _summaryItem(
            journey.isDirect ? Icons.arrow_forward_rounded : Icons.alt_route_rounded,
            journey.isDirect ? 'Direct' : 'Via',
            journey.isDirect ? 'Route' : 'Interchange',
            journey.isDirect ? AppTheme.success : AppTheme.warning,
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _dividerDot() {
    return Container(
      width: 3, height: 3,
      decoration: const BoxDecoration(color: AppTheme.textMuted, shape: BoxShape.circle),
    );
  }

  Widget _buildInterchangeCards(Journey journey) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: journey.interchanges.map((ic) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.warning.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.warning.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.swap_horiz_rounded, color: AppTheme.warning, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change at ${ic.station.name}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.warning),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 10, height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.getLineColor(ic.fromLineColor),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(ic.fromLine, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.textMuted),
                        ),
                        Container(
                          width: 10, height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.getLineColor(ic.toLineColor),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(ic.toLine, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      ],
                    ),
                    Text(
                      'Direction: ${ic.direction}',
                      style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildStationList(Journey journey) {
    final stations = journey.allStations;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        final isFirst = index == 0;
        final isLast = index == stations.length - 1;
        final isInterchange = journey.interchanges.any((ic) => ic.station.name == station.name);
        final lineColor = AppTheme.getLineColor(station.lineColor);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline
              SizedBox(
                width: 36,
                child: Column(
                  children: [
                    if (!isFirst)
                      Expanded(child: Container(width: 3, color: lineColor.withOpacity(0.4))),
                    Container(
                      width: isFirst || isLast || isInterchange ? 18 : 12,
                      height: isFirst || isLast || isInterchange ? 18 : 12,
                      decoration: BoxDecoration(
                        color: isFirst || isLast ? lineColor : (isInterchange ? AppTheme.warning : AppTheme.surfaceDark),
                        shape: BoxShape.circle,
                        border: Border.all(color: lineColor, width: 2.5),
                      ),
                      child: isFirst || isLast
                          ? Icon(
                              isFirst ? Icons.my_location_rounded : Icons.location_on_rounded,
                              color: Colors.white, size: 10,
                            )
                          : null,
                    ),
                    if (!isLast)
                      Expanded(child: Container(width: 3, color: lineColor.withOpacity(0.4))),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Station info
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: isFirst || isLast
                        ? lineColor.withOpacity(0.08)
                        : (isInterchange ? AppTheme.warning.withOpacity(0.06) : Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              station.name,
                              style: TextStyle(
                                fontSize: isFirst || isLast ? 15 : 13,
                                fontWeight: isFirst || isLast || isInterchange ? FontWeight.w600 : FontWeight.w400,
                                color: isFirst || isLast ? lineColor : AppTheme.textPrimary,
                              ),
                            ),
                            if (isInterchange)
                              Text('⇔ Interchange', style: TextStyle(fontSize: 10, color: AppTheme.warning)),
                          ],
                        ),
                      ),
                      if (isFirst || isLast)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: lineColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isFirst ? 'START' : 'END',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: lineColor),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStartButton(BuildContext context, JourneyProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              provider.startJourney();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ActiveJourneyScreen()),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded, size: 24),
            label: const Text('Start Journey', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accent,
              foregroundColor: AppTheme.primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              shadowColor: AppTheme.accent.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
