import 'package:flutter/material.dart';
import 'dart:math';


class JZLineBGPainter extends CustomPainter {
  EdgeInsets padding;
  int count;
  double gap;
  JZLineBGPainter({required this.count, this.padding = EdgeInsets.zero, this.gap = 3.0});

  @override
  bool shouldRepaint(JZLineBGPainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  void paint(Canvas canvas, Size size) {

    final double strokeWidth = 1;
    final color = Colors.grey;

    Paint linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = color;

    var y = padding.top;
    var x = padding.left;
    final bgSize = Size(size.width - padding.left - padding.right, size.height - padding.top - padding.bottom);
    if (count <= 1) {

    } else {
      final lineSpacing = bgSize.height / (count - 1);
      for (int i = 0; i < count; i++) {
        Point<double> to = Point((x + bgSize.width).floorToDouble(), y.floorToDouble());
        final path = this.getDashedPath(from: Point(x.floorToDouble(), y.floorToDouble()), to: to, gap: gap);
        y = y + lineSpacing;
        canvas.drawPath(path, linePaint);
      }
    }
  }


  /// 虚线
  Path getDashedPath({
    required Point<double> from, // 起始点
    required Point<double> to, // 终点
    required gap, // 间隙
  }) {
    Size size = Size(to.x - from.x, to.y - from.y);
    Path path = Path();
    path.moveTo(from.x, from.y);
    bool shouldDraw = true;
    Point<double> currentPoint = Point(from.x, from.y);

    num radians = atan(size.height / size.width);

    num dx = cos(radians) * gap < 0
        ? cos(radians) * gap * -1
        : cos(radians) * gap;

    num dy = sin(radians) * gap < 0
        ? sin(radians) * gap * -1
        : sin(radians) * gap;

    while (currentPoint.x <= to.x && currentPoint.y <= to.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }
}