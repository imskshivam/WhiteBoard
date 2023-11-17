import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:flutter_application_1/widgets/touch_points.dart';

class MycustomPainter extends CustomPainter {
  MycustomPainter({required this.pointList});
  List<TouchPoints> pointList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for (int i = 0; i < pointList.length - 1; i++) {
      if (pointList[i] != null && pointList[i + 1] != null) {
        canvas.drawLine(
            pointList[i].points, pointList[i + 1].points, pointList[i].paint);
      } else if (pointList[i] != null && pointList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointList[i].points);
        offsetPoints.add(Offset(
            pointList[i].points.dx + 0.1, pointList[i + 1].points.dy + 0.1));

        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
