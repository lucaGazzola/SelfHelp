import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BreathingSquare extends StatelessWidget {
  final int currentPhaseIndex; // 0: top (inhale), 1: right (hold), 2: bottom (exhale), 3: left (hold)
  final double phaseProgress; // 0.0 to 1.0 within current phase
  final String phaseName;
  final String instruction;
  final int secondsRemaining;
  final Color color;

  const BreathingSquare({
    super.key,
    required this.currentPhaseIndex,
    required this.phaseProgress,
    required this.phaseName,
    required this.instruction,
    required this.secondsRemaining,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: CustomPaint(
            painter: _SquareBreathingPainter(
              currentPhaseIndex: currentPhaseIndex,
              phaseProgress: phaseProgress,
              color: color,
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Center(
                  child: Text(
                    '$secondsRemaining',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: color,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
            ),
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
        const SizedBox(height: AppTheme.spacingLg),
        // Phase indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PhaseIndicator(
              label: 'Inhale',
              isActive: currentPhaseIndex == 0,
              color: color,
            ),
            _phaseDot(color),
            _PhaseIndicator(
              label: 'Hold',
              isActive: currentPhaseIndex == 1,
              color: color,
            ),
            _phaseDot(color),
            _PhaseIndicator(
              label: 'Exhale',
              isActive: currentPhaseIndex == 2,
              color: color,
            ),
            _phaseDot(color),
            _PhaseIndicator(
              label: 'Hold',
              isActive: currentPhaseIndex == 3,
              color: color,
            ),
          ],
        ),
      ],
    );
  }

  Widget _phaseDot(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _PhaseIndicator extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color color;

  const _PhaseIndicator({
    required this.label,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppTheme.shortAnimation,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          color: isActive ? color : AppTheme.textColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

class _SquareBreathingPainter extends CustomPainter {
  final int currentPhaseIndex;
  final double phaseProgress;
  final Color color;

  _SquareBreathingPainter({
    required this.currentPhaseIndex,
    required this.phaseProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final padding = 20.0;
    final rect = Rect.fromLTRB(
      padding,
      padding,
      size.width - padding,
      size.height - padding,
    );

    // Draw background square
    paint.color = color.withOpacity(0.15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      paint,
    );

    // Calculate corners
    final corners = [
      Offset(rect.left + 12, rect.top + 12), // Top-left
      Offset(rect.right - 12, rect.top + 12), // Top-right
      Offset(rect.right - 12, rect.bottom - 12), // Bottom-right
      Offset(rect.left + 12, rect.bottom - 12), // Bottom-left
    ];

    // Draw progress along the square
    paint.color = color;

    final path = Path();
    path.moveTo(corners[0].dx, corners[0].dy);

    // Calculate total progress through all phases
    double totalProgress = (currentPhaseIndex + phaseProgress) / 4;

    // Draw completed sides and progress
    for (int i = 0; i <= currentPhaseIndex; i++) {
      final start = corners[i];
      final end = corners[(i + 1) % 4];

      if (i < currentPhaseIndex) {
        // Fully completed side
        path.lineTo(end.dx, end.dy);
      } else {
        // Current side with progress
        final dx = start.dx + (end.dx - start.dx) * phaseProgress;
        final dy = start.dy + (end.dy - start.dy) * phaseProgress;
        path.lineTo(dx, dy);
      }
    }

    canvas.drawPath(path, paint);

    // Draw moving dot
    Offset dotPosition;
    final start = corners[currentPhaseIndex];
    final end = corners[(currentPhaseIndex + 1) % 4];
    dotPosition = Offset(
      start.dx + (end.dx - start.dx) * phaseProgress,
      start.dy + (end.dy - start.dy) * phaseProgress,
    );

    // Dot glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(dotPosition, 12, glowPaint);

    // Dot
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(dotPosition, 8, dotPaint);

    // Inner dot
    final innerDotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(dotPosition, 4, innerDotPaint);
  }

  @override
  bool shouldRepaint(_SquareBreathingPainter oldDelegate) =>
      oldDelegate.currentPhaseIndex != currentPhaseIndex ||
      oldDelegate.phaseProgress != phaseProgress ||
      oldDelegate.color != color;
}
