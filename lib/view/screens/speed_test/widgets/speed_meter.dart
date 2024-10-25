import 'dart:math';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';

// Custom Painter for the Speedometer Gauge
class SpeedometerPainter extends CustomPainter {
  final double progress;
  final double gaugeSize;
  final double strokeWidth;

  SpeedometerPainter(
      {required this.progress, required this.gaugeSize, this.strokeWidth = 12});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = gaugeSize / 2;
    double start = 5 * pi / 6.6;
    double sweep = 4 * pi / 2.7;

    // Background arc (grey)
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = strokeWidth - 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Progress arc
    Paint progressPaint = Paint()
      ..shader = primaryGradient.createShader(Rect.fromCircle(
          center: Offset(gaugeSize / 2, gaugeSize / 2), radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(gaugeSize / 2, gaugeSize / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      backgroundPaint,
    );

    double angle = progress * sweep;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      angle,
      false,
      progressPaint,
    );

    // Draw thumb (yellow circle at the end of the arc)
    double thumbX = gaugeSize / 2 + radius * cos(start + angle);
    double thumbY = gaugeSize / 2 + radius * sin(start + angle);
    canvas.drawCircle(Offset(thumbX, thumbY), 8,
        Paint()..color = primaryMaterialColor.shade100);
  }

  @override
  bool shouldRepaint(SpeedometerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gaugeSize != gaugeSize;
  }
}
