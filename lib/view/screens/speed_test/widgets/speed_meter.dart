import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom Painter for the Speedometer Gauge
class SpeedometerPainter extends CustomPainter {
  final double progress;
  final double gaugeSize; // Dynamic gauge size parameter
  final double strokeWidth;
  SpeedometerPainter(
      {required this.progress, required this.gaugeSize, this.strokeWidth = 12});

  @override
  void paint(Canvas canvas, Size size) {
    // Set gaugeSize to define the radius and dimensions of the circle
    double radius = gaugeSize / 2 - 12.sp;

    // Background circle
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = strokeWidth.sp
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [primaryMaterialColor.shade300, primaryColor],
      ).createShader(Rect.fromCircle(
          center: Offset(gaugeSize / 2, gaugeSize / 2), radius: radius))
      ..strokeWidth = strokeWidth.sp
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(gaugeSize / 2, gaugeSize / 2);

    // Draw the background circle
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -5 * 3.14159 / 4, 3 * 3.14159 / 2, false, backgroundPaint);

    // Draw the progress arc
    double angle =
        progress * 3 * 3.14159 / 2; // Progress from 0 to 1 -> 270 degrees
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -5 * 3.14159 / 4, angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(SpeedometerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gaugeSize != gaugeSize;
  }
}
