import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BreathingCircle extends StatelessWidget {
  final double progress; // 0.0 to 1.0 within current phase
  final String phaseName;
  final String instruction;
  final int secondsRemaining;
  final Color color;
  final bool isExpanding; // true for inhale, false for exhale

  const BreathingCircle({
    super.key,
    required this.progress,
    required this.phaseName,
    required this.instruction,
    required this.secondsRemaining,
    required this.color,
    required this.isExpanding,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scale based on phase
    double scale;
    if (phaseName == 'Inhale') {
      scale = 0.6 + (0.4 * progress); // 0.6 -> 1.0
    } else if (phaseName == 'Exhale') {
      scale = 1.0 - (0.4 * progress); // 1.0 -> 0.6
    } else {
      // Hold - maintain current size
      scale = isExpanding ? 1.0 : 0.6;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring (progress indicator)
              CustomPaint(
                size: const Size(280, 280),
                painter: _CircleProgressPainter(
                  progress: progress,
                  color: color,
                ),
              ),
              // Breathing circle
              AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.3),
                        color.withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(
                      color: color.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$secondsRemaining',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: color,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingXl),
        Text(
          phaseName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          instruction,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textColor.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CircleProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress, // Sweep angle
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
