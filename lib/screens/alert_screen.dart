import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AlertScreenType { destination, interchange }

class AlertScreen extends StatefulWidget {
  final AlertScreenType type;
  final String stationName;
  final String lineColor;
  final String? interchangeInstruction;
  final VoidCallback onDismiss;

  const AlertScreen({
    super.key,
    required this.type,
    required this.stationName,
    required this.lineColor,
    this.interchangeInstruction,
    required this.onDismiss,
  });

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDestination = widget.type == AlertScreenType.destination;
    final color = isDestination ? AppTheme.danger : AppTheme.warning;
    final lineColor = AppTheme.getLineColor(widget.lineColor);

    return Scaffold(
      backgroundColor: color.withOpacity(0.08),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Pulsing icon
              AnimatedBuilder2(
                listenable: _scaleAnimation,
                builder: (context, _) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        isDestination ? Icons.location_on_rounded : Icons.swap_horiz_rounded,
                        color: color,
                        size: 56,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              // Title
              Text(
                isDestination ? 'APPROACHING DESTINATION' : 'INTERCHANGE AHEAD',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              // Station name
              Text(
                widget.stationName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Line badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: lineColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(color: lineColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isDestination ? 'Your Destination' : 'Change Line Here',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: lineColor),
                    ),
                  ],
                ),
              ),
              if (widget.interchangeInstruction != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.warning.withOpacity(0.3)),
                  ),
                  child: Text(
                    widget.interchangeInstruction!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                isDestination
                    ? '🚉 Please prepare to get down'
                    : '🔄 Follow signage for platform change',
                style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Dismiss button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: widget.onDismiss,
                  icon: Icon(isDestination ? Icons.check_rounded : Icons.arrow_forward_rounded),
                  label: Text(
                    isDestination ? 'Got It — End Journey' : 'Got It — Continue',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: color.withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedBuilder2({super.key, required super.listenable, required this.builder});

  @override
  Widget build(BuildContext context) => builder(context, null);
}
