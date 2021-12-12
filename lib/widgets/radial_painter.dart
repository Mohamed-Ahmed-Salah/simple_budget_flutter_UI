import 'dart:math';
import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  final Color ngColor;
  final Color lineColor;
  double percent;
  final double width;

  RadialPainter({this.width, this.lineColor, this.ngColor, this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint()
      ..color = ngColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint completeLine = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center=Offset(size.width/2, size.height/2);
    double radius = min(size.width/2, size.height/2);

    double sweepAngle=2*pi *percent;
    canvas.drawCircle(center, radius, bgLine);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi/2, sweepAngle, false, completeLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
