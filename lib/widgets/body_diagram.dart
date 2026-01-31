import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BodyDiagram extends StatelessWidget {
  final String activeRegion;
  final bool isTensing; // true = tensing, false = relaxing
  final Color color;

  const BodyDiagram({
    super.key,
    required this.activeRegion,
    required this.isTensing,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 320,
      child: CustomPaint(
        painter: _BodyDiagramPainter(
          activeRegion: activeRegion,
          isTensing: isTensing,
          color: color,
        ),
      ),
    );
  }
}

class _BodyDiagramPainter extends CustomPainter {
  final String activeRegion;
  final bool isTensing;
  final Color color;

  _BodyDiagramPainter({
    required this.activeRegion,
    required this.isTensing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final defaultPaint = Paint()
      ..color = AppTheme.textColor.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final activePaint = Paint()
      ..color = isTensing ? color : color.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // Helper to get paint based on region
    Paint getPaint(String region) {
      return activeRegion.toLowerCase().contains(region.toLowerCase())
          ? activePaint
          : defaultPaint;
    }

    // Head
    final headPaint = getPaint('forehead') == activePaint ||
            getPaint('eyes') == activePaint ||
            getPaint('jaw') == activePaint ||
            getPaint('face') == activePaint
        ? activePaint
        : defaultPaint;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, 30),
        width: 50,
        height: 55,
      ),
      headPaint,
    );

    // Neck
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, 65),
        width: 25,
        height: 20,
      ),
      getPaint('neck'),
    );

    // Shoulders
    final shoulderPath = Path();
    shoulderPath.moveTo(centerX - 12, 70);
    shoulderPath.lineTo(centerX - 70, 85);
    shoulderPath.lineTo(centerX - 70, 100);
    shoulderPath.lineTo(centerX - 12, 90);
    shoulderPath.close();
    canvas.drawPath(shoulderPath, getPaint('shoulder'));

    final shoulderPathRight = Path();
    shoulderPathRight.moveTo(centerX + 12, 70);
    shoulderPathRight.lineTo(centerX + 70, 85);
    shoulderPathRight.lineTo(centerX + 70, 100);
    shoulderPathRight.lineTo(centerX + 12, 90);
    shoulderPathRight.close();
    canvas.drawPath(shoulderPathRight, getPaint('shoulder'));

    // Torso (chest + stomach)
    final torsoPaint = getPaint('chest') == activePaint || getPaint('stomach') == activePaint
        ? activePaint
        : defaultPaint;

    final torsoPath = Path();
    torsoPath.moveTo(centerX - 45, 90);
    torsoPath.lineTo(centerX - 35, 180);
    torsoPath.lineTo(centerX + 35, 180);
    torsoPath.lineTo(centerX + 45, 90);
    torsoPath.close();
    canvas.drawPath(torsoPath, torsoPaint);

    // Upper Arms
    _drawLimb(
      canvas,
      Offset(centerX - 70, 95),
      Offset(centerX - 75, 150),
      20,
      getPaint('upper arms') == activePaint || getPaint('arms') == activePaint
          ? activePaint
          : defaultPaint,
    );
    _drawLimb(
      canvas,
      Offset(centerX + 70, 95),
      Offset(centerX + 75, 150),
      20,
      getPaint('upper arms') == activePaint || getPaint('arms') == activePaint
          ? activePaint
          : defaultPaint,
    );

    // Forearms and Hands
    _drawLimb(
      canvas,
      Offset(centerX - 75, 150),
      Offset(centerX - 80, 210),
      16,
      getPaint('hands') == activePaint || getPaint('forearm') == activePaint
          ? activePaint
          : defaultPaint,
    );
    _drawLimb(
      canvas,
      Offset(centerX + 75, 150),
      Offset(centerX + 80, 210),
      16,
      getPaint('hands') == activePaint || getPaint('forearm') == activePaint
          ? activePaint
          : defaultPaint,
    );

    // Hands
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX - 82, 220),
        width: 18,
        height: 22,
      ),
      getPaint('hands'),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + 82, 220),
        width: 18,
        height: 22,
      ),
      getPaint('hands'),
    );

    // Hips/Pelvis
    final hipPath = Path();
    hipPath.moveTo(centerX - 35, 180);
    hipPath.lineTo(centerX - 40, 205);
    hipPath.lineTo(centerX + 40, 205);
    hipPath.lineTo(centerX + 35, 180);
    hipPath.close();
    canvas.drawPath(hipPath, getPaint('hips'));

    // Thighs
    _drawLimb(
      canvas,
      Offset(centerX - 25, 205),
      Offset(centerX - 25, 260),
      25,
      getPaint('thigh'),
    );
    _drawLimb(
      canvas,
      Offset(centerX + 25, 205),
      Offset(centerX + 25, 260),
      25,
      getPaint('thigh'),
    );

    // Lower Legs/Calves
    _drawLimb(
      canvas,
      Offset(centerX - 25, 260),
      Offset(centerX - 25, 310),
      20,
      getPaint('calves') == activePaint || getPaint('feet') == activePaint
          ? activePaint
          : defaultPaint,
    );
    _drawLimb(
      canvas,
      Offset(centerX + 25, 260),
      Offset(centerX + 25, 310),
      20,
      getPaint('calves') == activePaint || getPaint('feet') == activePaint
          ? activePaint
          : defaultPaint,
    );

    // Feet
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX - 25, 318),
        width: 24,
        height: 16,
      ),
      getPaint('feet'),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + 25, 318),
        width: 24,
        height: 16,
      ),
      getPaint('feet'),
    );

    // Draw pulse effect on active region if tensing
    if (isTensing) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      // Add glow around the body
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        glowPaint,
      );
    }
  }

  void _drawLimb(Canvas canvas, Offset start, Offset end, double width, Paint paint) {
    final path = Path();
    final perpendicular = Offset(
      -(end.dy - start.dy),
      end.dx - start.dx,
    );
    final normalized = perpendicular / perpendicular.distance;
    final halfWidth = width / 2;

    path.moveTo(
      start.dx + normalized.dx * halfWidth,
      start.dy + normalized.dy * halfWidth,
    );
    path.lineTo(
      end.dx + normalized.dx * halfWidth * 0.8,
      end.dy + normalized.dy * halfWidth * 0.8,
    );
    path.lineTo(
      end.dx - normalized.dx * halfWidth * 0.8,
      end.dy - normalized.dy * halfWidth * 0.8,
    );
    path.lineTo(
      start.dx - normalized.dx * halfWidth,
      start.dy - normalized.dy * halfWidth,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BodyDiagramPainter oldDelegate) =>
      oldDelegate.activeRegion != activeRegion ||
      oldDelegate.isTensing != isTensing ||
      oldDelegate.color != color;
}

