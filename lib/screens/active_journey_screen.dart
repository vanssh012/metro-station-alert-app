import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/journey_provider.dart';
import '../models/journey.dart';
import 'alert_screen.dart';
import 'home_screen.dart';

class ActiveJourneyScreen extends StatelessWidget {
  const ActiveJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JourneyProvider>(
      builder: (context, provider, _) {
        final journey = provider.currentJourney;
        if (journey == null) {
          return const Scaffold(body: Center(child: Text('No active journey')));
        }

        // Show alert screen if approaching destination/interchange
        if (provider.status == JourneyStatus.approachingDestination ||
            provider.status == JourneyStatus.arrived) {
          return AlertScreen(
            type: AlertScreenType.destination,
            stationName: journey.endStation.name,
            lineColor: journey.endStation.lineColor,
            onDismiss: () {
              provider.completeJourney();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (_) => false,
              );
            },
          );
        }

        if (provider.status == JourneyStatus.approachingInterchange) {
          final ic = journey.interchanges.firstWhere(
            (i) => i.station.name == provider.nextInterchange?.name,
            orElse: () => journey.interchanges.first,
          );
          return AlertScreen(
            type: AlertScreenType.interchange,
            stationName: ic.station.name,
            lineColor: ic.toLineColor,
            interchangeInstruction: ic.instruction,
            onDismiss: () {
              provider.startJourney(); // Resume tracking
            },
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  _buildHeader(context, provider),
                  const SizedBox(height: 20),
                  _buildProgressCard(provider, journey),
                  const SizedBox(height: 16),
                  _buildCurrentStationCard(provider),
                  const SizedBox(height: 16),
                  if (provider.nextInterchange != null)
                    _buildNextInterchangeCard(provider, journey),
                  const Spacer(),
                  _buildStopButton(context, provider),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, JourneyProvider provider) {
    final journey = provider.currentJourney!;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.success.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.navigation_rounded, color: AppTheme.success, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Active Journey', style: TextStyle(fontSize: 11, color: AppTheme.success, fontWeight: FontWeight.w600)),
              Text(
                '${journey.startStation.name} → ${journey.endStation.name}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Simulate next station button (for testing)
        IconButton(
          onPressed: () => provider.advanceToNextStation(),
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.skip_next_rounded, color: AppTheme.accent, size: 20),
          ),
          tooltip: 'Simulate: Next station (testing)',
        ),
      ],
    );
  }

  Widget _buildProgressCard(JourneyProvider provider, Journey journey) {
    final progress = provider.journeyProgress;
    final remaining = provider.stationsRemaining;
    final eta = (remaining * 2.5).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.surfaceDark, AppTheme.cardDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.cardDark,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _progressStat(Icons.format_list_numbered_rounded, '$remaining', 'Stations left', AppTheme.accent),
              Container(width: 1, height: 30, color: AppTheme.divider),
              _progressStat(Icons.timer_rounded, '~$eta min', 'ETA', AppTheme.yellowLineColor),
              Container(width: 1, height: 30, color: AppTheme.divider),
              _progressStat(Icons.percent_rounded, '${(progress * 100).round()}%', 'Complete', AppTheme.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressStat(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
      ],
    );
  }

  Widget _buildCurrentStationCard(JourneyProvider provider) {
    final current = provider.currentStation;
    final next = provider.nextStation;
    if (current == null) return const SizedBox.shrink();

    final lineColor = AppTheme.getLineColor(current.lineColor);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: lineColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: lineColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12, height: 12,
                decoration: BoxDecoration(color: lineColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Text(current.lineName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: lineColor)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Station', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                    const SizedBox(height: 2),
                    Text(current.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, color: AppTheme.textMuted, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Next Station', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                    const SizedBox(height: 2),
                    Text(
                      next?.name ?? 'Destination',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textSecondary),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (provider.distanceToNextStation != null) ...[
            const SizedBox(height: 10),
            Text(
              '${(provider.distanceToNextStation! / 1000).toStringAsFixed(1)} km to next station',
              style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNextInterchangeCard(JourneyProvider provider, Journey journey) {
    final ic = journey.interchanges.firstWhere(
      (i) => i.station.name == provider.nextInterchange?.name,
      orElse: () => journey.interchanges.first,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.warning.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.swap_horiz_rounded, color: AppTheme.warning, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upcoming Interchange', style: TextStyle(fontSize: 11, color: AppTheme.warning, fontWeight: FontWeight.w600)),
                Text(ic.instruction, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopButton(BuildContext context, JourneyProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: AppTheme.surfaceDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Stop Journey?', style: TextStyle(color: AppTheme.textPrimary)),
              content: const Text('Are you sure you want to stop tracking?', style: TextStyle(color: AppTheme.textSecondary)),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    provider.stopJourney();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
                  child: const Text('Stop', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.stop_rounded, size: 22),
        label: const Text('Stop Journey', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.danger.withOpacity(0.15),
          foregroundColor: AppTheme.danger,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
    );
  }
}
