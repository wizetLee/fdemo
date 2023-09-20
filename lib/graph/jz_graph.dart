/*
 * @ProjectName : fdemo
 * @Author : wizet
 * @Time : 2023/7/7 09:02
 * @Description :
 */

// bgRenderer
//
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 绘画工具
class JZGraphTool {}

/// 文字相关
extension JZGraphToolTextPainter on JZGraphTool {

  /// 绘制文字
  void drawText(
      {required Canvas canvas,
      required Offset paintAt,
      required String text,
      required TextStyle style,
      TextDirection? textDirection}) {
    // 可计算尺寸
    TextSpan textSpan = TextSpan(text: text, style: style);
    TextPainter textPainter =
        TextPainter(text: textSpan, textDirection: textDirection);
    textPainter.layout();
    // textPainter.width
    // textPainter.height
    textPainter.paint(canvas, paintAt);
    // TextPainter textPainter = getTextPainter(date, style: style);
  }

}

/// 线相关
extension JZGraphToolLines on JZGraphTool {

  /// 绘制虚线（垂直/水平方向
  void drawDashedLine(
      {required Canvas canvas, // 画布
        required Paint linePaint,
        required Offset paintAt, // 开始的绘制点
        required double width, // 线长度
        double gap = 4, // 间隔
        double dashedWidth = 4, // 宽
        Axis axis = Axis.horizontal, // 方向
      }) {

    var start = (axis == Axis.horizontal) ? paintAt.dx : paintAt.dy;
    final end = start + width;
    while (start < end) {
      var p1Value = start;
      var p2Value = start + gap;
      if (p2Value > end) {
        p2Value = end;
      }
      if (axis == Axis.horizontal) {
        canvas.drawLine(Offset(p1Value, paintAt.dy), Offset(p2Value, paintAt.dy), linePaint);
      } else {
        canvas.drawLine(Offset(paintAt.dx, p1Value), Offset(paintAt.dx, p2Value), linePaint);
      }
      start = p2Value;
    }
  }

  /// 虚线（任意两点
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
