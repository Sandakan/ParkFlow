import 'package:flutter/material.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';

class SpotPickerCanvas extends StatelessWidget {
  final InteractionMode mode;
  final List<Offset> normalizedCurrentPoints;
  final List<ParkingSlotModel> slots;
  final bool showAiDetections;
  final Function(Offset normalizedPoint) onTap;

  const SpotPickerCanvas({
    required this.mode,
    required this.normalizedCurrentPoints,
    required this.slots,
    required this.showAiDetections,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onTapDown: (details) {
            if (mode == InteractionMode.drawing) {
              final normalized = Offset(
                details.localPosition.dx / size.width,
                details.localPosition.dy / size.height,
              );
              onTap(normalized);
            }
          },
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: _SpotPainter(
                mode: mode,
                normalizedCurrentPoints: normalizedCurrentPoints,
                slots: slots,
                showAiDetections: showAiDetections,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SpotPainter extends CustomPainter {
  final InteractionMode mode;
  final List<Offset> normalizedCurrentPoints;
  final List<ParkingSlotModel> slots;
  final bool showAiDetections;

  _SpotPainter({
    required this.mode,
    required this.normalizedCurrentPoints,
    required this.slots,
    required this.showAiDetections,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    // 1. Draw existing slots
    for (final slot in slots) {
      if (slot.coordinates == null || slot.coordinates!.isEmpty) continue;

      final path = Path();
      final points = slot.coordinates!
          .map((p) => Offset(p.x * size.width, p.y * size.height))
          .toList();

      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      path.close();

      // Determine Colors based on type and status
      Color baseColor;
      if (slot.isOccupied) {
        baseColor = Colors.red;
      } else {
        switch (slot.slotType) {
          case 'disabled':
            baseColor = Colors.blue;
            break;
          case 'ev':
            baseColor = Colors.green;
            break;
          default:
            baseColor = AppColors.primary;
        }
      }

      final currentFillPaint = Paint()
        ..color = baseColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;

      final currentStrokePaint = Paint()
        ..color = baseColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawPath(path, currentFillPaint);
      canvas.drawPath(path, currentStrokePaint);

      // Draw slot name
      final textPainter = TextPainter(
        text: TextSpan(
          text: slot.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      // Center of polygon roughly
      double avgX =
          points.map((p) => p.dx).reduce((a, b) => a + b) / points.length;
      double avgY =
          points.map((p) => p.dy).reduce((a, b) => a + b) / points.length;
      textPainter.paint(
        canvas,
        Offset(avgX - textPainter.width / 2, avgY - textPainter.height / 2),
      );
    }

    // 2. Draw current polygon being created
    if (mode == InteractionMode.drawing && normalizedCurrentPoints.isNotEmpty) {
      final currentPoints = normalizedCurrentPoints
          .map((p) => Offset(p.dx * size.width, p.dy * size.height))
          .toList();

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
          canvas.drawLine(currentPoints[i], currentPoints[i + 1], strokePaint);
        }
      }

      // If full shape, close it
      if (currentPoints.length == 4) {
        canvas.drawLine(currentPoints.last, currentPoints.first, strokePaint);

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
        oldDelegate.normalizedCurrentPoints != normalizedCurrentPoints ||
        oldDelegate.slots != slots ||
        oldDelegate.showAiDetections != showAiDetections;
  }
}
