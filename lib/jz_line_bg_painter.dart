import 'package:flutter/material.dart';
import 'dart:math';

class JZLineBGPainter extends CustomPainter {
  EdgeInsets padding;
  int count;

  // 线的间距
  double gap;
  List<TextSpan> left;
  List<TextSpan> right;

  // 是否需要边界线 false
  bool needBorder;

  double ruleGaps;

  JZLineBGPainter({
    required this.count,
    this.padding = EdgeInsets.zero,
    this.gap = 4.0,
    this.left = const [],
    this.right = const [],
    this.needBorder = false,
    this.ruleGaps = 0.0,
  });

  @override
  bool shouldRepaint(JZLineBGPainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 1;
    // 背景线的颜色
    final color = Colors.grey;

    Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    var y = padding.top;
    var x = padding.left;
    final bgSize = Size(size.width - padding.left - padding.right,
        size.height - padding.top - padding.bottom);
    if (count <= 1) {
    } else {
      final lineSpacing = bgSize.height / (count - 1);
      for (int i = 0; i < count; i++) {
        Point<double> to =
            Point((x + bgSize.width).floorToDouble(), y.floorToDouble());
        final path = getDashedPath(
            from: Point(x.floorToDouble(), y.floorToDouble()),
            to: to,
            gap: gap);
        if (needBorder == false) {
          if (!(i == 0 || (i == (count - 1)))) {
            canvas.drawPath(path, linePaint);
          }
        } else {
          canvas.drawPath(path, linePaint);
        }

        if (left.length > i) {
          final TextPainter textPainter = TextPainter(
              text: left[i],
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr);
          textPainter.layout();
          if (i == 0) {
            textPainter.paint(canvas,
                Offset(x.floorToDouble() + ruleGaps, y.floorToDouble()));
          } else if (i == (count - 1)) {
            textPainter.paint(
                canvas,
                Offset(x.floorToDouble() + ruleGaps,
                    y.floorToDouble() - textPainter.height));
          } else {
            textPainter.paint(
                canvas,
                Offset(x.floorToDouble() + ruleGaps,
                    y.floorToDouble() - textPainter.height / 2));
          }
        }
        if (right.length > i) {
          final TextPainter textPainter = TextPainter(
              text: left[i],
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr);
          textPainter.layout();
          textPainter.height;
          if (i == 0) {
            textPainter.paint(
                canvas, Offset(to.x - textPainter.width - ruleGaps, to.y));
          } else if (i == (count - 1)) {
            textPainter.paint(
                canvas,
                Offset(to.x - textPainter.width - ruleGaps,
                    to.y - textPainter.height));
          } else {
            textPainter.paint(
                canvas,
                Offset(to.x - textPainter.width - ruleGaps,
                    to.y - textPainter.height / 2));
          }
        }
        y = y + lineSpacing;
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

    num dx =
        cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;

    num dy =
        sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;

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
