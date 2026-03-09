import 'package:flutter/material.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/models/parking/ai_detection_event.dart';

class SpotPickerCanvas extends StatelessWidget {
  final InteractionMode mode;
  final List<Offset> normalizedCurrentPoints;
  final List<ParkingSlotModel> slots;
  final bool showAiDetections;
  final List<DetectedBox> aiDetections;
  final Map<String, bool> aiSlotHits;
  final Function(Offset normalizedPoint) onTap;

  const SpotPickerCanvas({
    required this.mode,
    required this.normalizedCurrentPoints,
    required this.slots,
    required this.showAiDetections,
    required this.aiDetections,
    required this.aiSlotHits,
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
                aiDetections: aiDetections,
                aiSlotHits: aiSlotHits,
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
  final List<DetectedBox> aiDetections;
  final Map<String, bool> aiSlotHits;

  _SpotPainter({
    required this.mode,
    required this.normalizedCurrentPoints,
    required this.slots,
    required this.showAiDetections,
    required this.aiDetections,
    required this.aiSlotHits,
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

    // 1. Draw existing slots — color overridden by live AI hits when active
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

      // If AI stream is active and has a hit for this slot, use AI color;
      // otherwise fall back to DB-persisted status color.
      Color baseColor;
      if (showAiDetections && aiSlotHits.containsKey(slot.id)) {
        baseColor = aiSlotHits[slot.id]! ? Colors.red : Colors.green;
      } else if (slot.isOccupied) {
        baseColor = Colors.red;
      } else {
        switch (slot.slotType) {
          case 'disabled':
            baseColor = Colors.blue;
          case 'ev':
            baseColor = Colors.green;
          default:
            baseColor = AppColors.primary;
        }
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = baseColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = baseColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      // Slot name label
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
      final avgX =
          points.map((p) => p.dx).reduce((a, b) => a + b) / points.length;
      final avgY =
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

      for (final point in currentPoints) {
        canvas.drawCircle(point, 4.0, pointPaint);
      }

      if (currentPoints.length > 1) {
        for (int i = 0; i < currentPoints.length - 1; i++) {
          canvas.drawLine(currentPoints[i], currentPoints[i + 1], strokePaint);
        }
      }

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

    // 3. Draw live YOLO detection bounding boxes
    if (showAiDetections && aiDetections.isNotEmpty) {
      for (final det in aiDetections) {
        final labelLower = det.label.toLowerCase();

        Color color;
        if (labelLower == 'space-empty') {
          color = Colors.greenAccent;
        } else if (labelLower == 'space-occupied') {
          color = Colors.redAccent;
        } else {
          color = Colors.yellowAccent;
        }

        final boxPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

        final rect = Rect.fromLTRB(
          det.x1 * size.width,
          det.y1 * size.height,
          det.x2 * size.width,
          det.y2 * size.height,
        );
        canvas.drawRect(rect, boxPaint);

        // Label above box
        final labelText =
            '${det.label} ${(det.confidence * 100).toStringAsFixed(0)}%';
        final labelPainter = TextPainter(
          text: TextSpan(
            text: labelText,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        labelPainter.layout();

        // Small background chip for readability
        final labelBg = Rect.fromLTWH(
          rect.left,
          rect.top - labelPainter.height - 4,
          labelPainter.width + 6,
          labelPainter.height + 4,
        );
        canvas.drawRect(
          labelBg,
          Paint()..color = Colors.black.withValues(alpha: 0.6),
        );
        labelPainter.paint(
          canvas,
          Offset(rect.left + 3, rect.top - labelPainter.height - 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SpotPainter oldDelegate) {
    return oldDelegate.mode != mode ||
        oldDelegate.normalizedCurrentPoints != normalizedCurrentPoints ||
        oldDelegate.slots != slots ||
        oldDelegate.showAiDetections != showAiDetections ||
        oldDelegate.aiDetections != aiDetections ||
        oldDelegate.aiSlotHits != aiSlotHits;
  }
}
