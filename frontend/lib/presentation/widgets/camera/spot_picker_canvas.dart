import 'package:flutter/material.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';

class SpotPickerCanvas extends StatelessWidget {
  final InteractionMode mode;
  final List<Offset> currentPoints;
  final bool showAiDetections;
  final Function(Offset) onTap;

  const SpotPickerCanvas({
    required this.mode,
    required this.currentPoints,
    required this.showAiDetections,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (mode == InteractionMode.drawing) {
          onTap(details.localPosition);
        }
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: _SpotPainter(
            mode: mode,
            currentPoints: currentPoints,
            showAiDetections: showAiDetections,
          ),
        ),
      ),
    );
  }
}

class _SpotPainter extends CustomPainter {
  final InteractionMode mode;
  final List<Offset> currentPoints;
  final bool showAiDetections;

  _SpotPainter({
    required this.mode,
    required this.currentPoints,
    required this.showAiDetections,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw existing slots (mocked for now)

    // 2. Draw current polygon being created
    if (mode == InteractionMode.drawing && currentPoints.isNotEmpty) {
      final paint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final pointPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.fill;

      // Draw points
      for (final point in currentPoints) {
        canvas.drawCircle(point, 4.0, pointPaint);
      }

      // Draw lines between points
      if (currentPoints.length > 1) {
        for (int i = 0; i < currentPoints.length - 1; i++) {
          canvas.drawLine(currentPoints[i], currentPoints[i + 1], paint);
        }
      }

      // If full shape, close it
      if (currentPoints.length == 4) {
        canvas.drawLine(currentPoints.last, currentPoints.first, paint);

        // Fill semi-transparent
        final fillPaint = Paint()
          ..color = AppColors.primary.withValues(alpha: 0.2)
          ..style = PaintingStyle.fill;

        final path = Path()..moveTo(currentPoints[0].dx, currentPoints[0].dy);
        for (int i = 1; i < currentPoints.length; i++) {
          path.lineTo(currentPoints[i].dx, currentPoints[i].dy);
        }
        path.close();
        canvas.drawPath(path, fillPaint);
      }
    }

    // 3. Draw AI Detections (mocked)
    if (showAiDetections) {
      final aiPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final rect = Rect.fromLTWH(
        size.width * 0.4,
        size.height * 0.4,
        size.width * 0.2,
        size.height * 0.2,
      );
      canvas.drawRect(rect, aiPaint);

      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'Car 0.98',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(rect.left, rect.top - 16));
    }
  }

  @override
  bool shouldRepaint(covariant _SpotPainter oldDelegate) {
    return oldDelegate.mode != mode ||
        oldDelegate.currentPoints != currentPoints ||
        oldDelegate.showAiDetections != showAiDetections;
  }
}
