import 'dart:math';

import 'package:flutter/material.dart';

import 'helper.dart';
class CircularGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Define different paints for segments
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final yellowPaint = Paint()
      ..color = AppColor.pinkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final navyPaint = Paint()
      ..color = AppColor.orangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final purplePaint = Paint()
      ..color = AppColor.purpleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    // Draw background circles
    canvas.drawCircle(center, radius - 20, backgroundPaint);
    canvas.drawCircle(center, radius - 40, backgroundPaint);
    canvas.drawCircle(center, radius - 60, backgroundPaint);

    // Draw arcs
    drawArc(canvas, center, radius - 20, -90, 270, purplePaint); // Outer yellow
    drawArc(canvas, center, radius - 40, -60, 240, navyPaint); // Middle navy
    drawArc(canvas, center, radius - 60, -30, 180, yellowPaint); // Inner yellow
  }

  void drawArc(Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle, Paint paint) {
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, radians(startAngle), radians(sweepAngle), false, paint);
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Legend Widget
class Legend extends StatelessWidget {
  final Color color;
  final String text;

  const Legend({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 15, height: 15, decoration: BoxDecoration(color: color,)),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 15),
      ],
    );
  }
}