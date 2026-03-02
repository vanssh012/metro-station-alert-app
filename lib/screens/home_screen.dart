import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/journey_provider.dart';
import '../data/metro_data_provider.dart';
import 'station_selection_screen.dart';
import 'route_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _selectStation(BuildContext context, bool isStart) async {
    final result = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(
        builder: (_) => StationSelectionScreen(
          title: isStart ? 'Select Start Station' : 'Select Destination',
        ),
      ),
    );
    if (result != null && mounted) {
      final provider = context.read<JourneyProvider>();
      if (isStart) {
        provider.setStartStation(result);
      } else {
        provider.setEndStation(result);
      }
    }
  }

  void _planRoute(BuildContext context) {
    final provider = context.read<JourneyProvider>();
    final journey = provider.planRoute();
    if (journey != null) {
      provider.addToRecent();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoutePreviewScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not find a route between these stations'),
          backgroundColor: AppTheme.danger,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildJourneyCard(context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildRecentJourneys(context),
              const SizedBox(height: 24),
              _buildFeatureCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accent, Color(0xFF6C63FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.train_rounded, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MetroWake',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Never miss your station again',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.accent.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_rounded, color: AppTheme.textMuted),
        ),
      ],
    );
  }

  Widget _buildJourneyCard(BuildContext context) {
    return Consumer<JourneyProvider>(
      builder: (context, journey, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.surfaceDark,
                AppTheme.surfaceDark.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.divider),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accent.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.route_rounded, color: AppTheme.accent, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Plan Your Journey',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  if (journey.startStation != null && journey.endStation != null)
                    GestureDetector(
                      onTap: () => journey.swapStations(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.swap_vert_rounded, color: AppTheme.accent, size: 20),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              // Start station
              _buildStationSelector(
                icon: Icons.my_location_rounded,
                iconColor: AppTheme.success,
                label: journey.startStation?.name ?? 'Select start station',
                isSelected: journey.startStation != null,
                onTap: () => _selectStation(context, true),
              ),
              // Connecting line
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Container(
                  width: 2,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.success, AppTheme.danger],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // End station
              _buildStationSelector(
                icon: Icons.location_on_rounded,
                iconColor: AppTheme.danger,
                label: journey.endStation?.name ?? 'Select destination',
                isSelected: journey.endStation != null,
                onTap: () => _selectStation(context, false),
              ),
              const SizedBox(height: 20),
              // Start journey button
              SizedBox(
                width: double.infinity,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final canPlan = journey.startStation != null && journey.endStation != null;
                    return ElevatedButton(
                      onPressed: canPlan ? () => _planRoute(context) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canPlan ? AppTheme.accent : AppTheme.surfaceDark,
                        foregroundColor: canPlan ? AppTheme.primaryDark : AppTheme.textMuted,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: canPlan ? 4 : 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.navigation_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Find Route',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStationSelector({
    required IconData icon,
    required Color iconColor,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? iconColor.withValues(alpha: 0.3) : AppTheme.divider,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? AppTheme.textPrimary : AppTheme.textMuted,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final dataProvider = context.read<MetroDataProvider>();
    final lineCount = dataProvider.lines.length;
    final stationCount = dataProvider.stations.length;

    return Row(
      children: [
        _buildInfoChip(Icons.train_rounded, '$stationCount Stations', AppTheme.blueLineColor),
        const SizedBox(width: 10),
        _buildInfoChip(Icons.linear_scale_rounded, '$lineCount Lines', AppTheme.yellowLineColor),
        const SizedBox(width: 10),
        _buildInfoChip(Icons.swap_horiz_rounded, '2 Networks', AppTheme.rrtsColor),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentJourneys(BuildContext context) {
    return Consumer<JourneyProvider>(
      builder: (context, journey, _) {
        if (journey.recentJourneys.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Journeys',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...journey.recentJourneys.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () {
                  journey.setStartStation(r['start']!);
                  journey.setEndStation(r['end']!);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.history_rounded, color: AppTheme.textMuted, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${r['start']!.name} → ${r['end']!.name}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.textMuted, size: 14),
                    ],
                  ),
                ),
              ),
            )),
          ],
        );
      },
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _featureCard(Icons.notifications_active_rounded, 'Smart Alerts', 'Vibration + Sound + Notification', AppTheme.accent)),
            const SizedBox(width: 12),
            Expanded(child: _featureCard(Icons.swap_calls_rounded, 'Interchange\nGuidance', 'Line change instructions', AppTheme.pinkLineColor)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _featureCard(Icons.bedtime_rounded, 'Sleep Mode', 'Override silent mode', AppTheme.violetLineColor)),
            const SizedBox(width: 12),
            Expanded(child: _featureCard(Icons.wifi_off_rounded, 'Offline Mode', 'No internet needed', AppTheme.success)),
          ],
        ),
      ],
    );
  }

  Widget _featureCard(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}

