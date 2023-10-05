import 'dart:math';

import 'package:flutter/material.dart';
import '../jz_graph.dart';
import '../jz_rg_painter_model.dart';
import '../jz_rich_graph_renderer.dart';

/// 多线绘制模型
class JZRGLinesPainter extends CustomPainter {
  /// 线的模型（可多条）
  final List<JZRGEachPainterModel> lineModels;

  /// 绘制相关的参数
  JZRichGraphRendererParam param;

  JZRGLinesPainter({
    required this.lineModels,
    required this.param,
    super.repaint,
  });

  /// 垂直线的的配置
  late Paint groundConnectorPaint = Paint()
    ..strokeWidth = 1
    ..color = Colors.blue;

  // 垂直方向上的线 - 手势的
  late Paint locationInLinePaint = Paint()
    ..strokeWidth = 1
    ..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    var x = param.param.renderPadding.left;
    final renderSize = Size(
        size.width -
            param.param.renderPadding.left -
            param.param.renderPadding.right,
        size.height -
            param.param.renderPadding.top -
            param.param.renderPadding.bottom);

    final models = lineModels;
    var maxLength = 0;
    {
      for (int i = 0; i < models.length; i++) {
        if (models[i].elements.length > maxLength) {
          maxLength = models[i].elements.length;
        }
      }
    }

    final visibleCount =
        (param.param.visibleCount > 0) ? param.param.visibleCount : maxLength;
    if (visibleCount <= 1) {
      return;
    }

    final widthPerItem = renderSize.width / (visibleCount);

    var didDrawLocationIn = false;
    double? shouldLocationInX;

    // 重合也没关系
    Map<Offset, JZRGEachPainterModel> pointMap = {};

    List<Offset> needGroundConnectorFromPoints = [];
    for (var element in models) {
      Offset? range;
      if (element.axisDirection == AxisDirection.left) {
        range = param.param.rangeLeft(models: lineModels);
      } else if (element.axisDirection == AxisDirection.right) {
        range = param.param.rangeRight(models: lineModels);
      }

      // 获取所有数据的最值
      if (range == null) {
        continue; // 下一个循环
      }
      double max = range.dy;
      double min = range.dx;

      /// 绘制的是数值
      var heightValue = max - min;
      var heightPerValue = renderSize.height / heightValue;

      double startX = x + widthPerItem / 2;

      // 每条线的绘制
      var linePaint = Paint()
        ..strokeWidth = element.strokeWidth
        ..color = element.color
        ..strokeJoin = StrokeJoin.round;

      final lines = element.elements;
      {
        // 位置计算
        if (element.elements.length > 0) {
          Offset? from;
          for (int i = 0; i < visibleCount; i++) {
            if (lines.length > i) {
              /// 得到绘制的坐标
              final y = (max - lines[i].renderValue) * heightPerValue;
              final to = Offset(startX, y);

              if (element.style == JZRGEachPainterModelStyle.line) {
                if (from != null) {
                  // 绘制直线
                  canvas.drawLine(from, to, linePaint);
                }
              } else if (element.style == JZRGEachPainterModelStyle.columnar) {
                canvas.drawLine(
                    to, Offset(startX, renderSize.height / 2), linePaint);
              } else if (element.style ==
                  JZRGEachPainterModelStyle.positiveColumnar) {
                canvas.drawLine(
                    to, Offset(startX, renderSize.height), linePaint);
              }

              // 位置记录
              from = to;

              if (element.style == JZRGEachPainterModelStyle.line) {
                if (param.param.needGroundConnector) {
                  needGroundConnectorFromPoints.add(from);
                }
              }

              {
                if (param.locationIn == i) {
                  if (didDrawLocationIn == false) {
                    shouldLocationInX = startX;
                    didDrawLocationIn = true;
                  }
                  if (element.showGesturePoint) {
                    pointMap[from] = element;
                  }

                  if (models.length == 1) {
                    if (element.style == JZRGEachPainterModelStyle.line) {
                      canvas.drawLine(Offset(0, to.dy),
                          Offset(renderSize.width, to.dy), locationInLinePaint);
                    }
                  }
                }
              }

              startX = startX + widthPerItem;
            }
          }
        }
        // else if (lines.length == 1) {
        //   //FIXME: 有时一个点的时候也需要处理
        // }
      }
    }

    needGroundConnectorFromPoints.forEach((from) {
      JZGraphTool().drawDashedLine(
          canvas: canvas,
          linePaint: groundConnectorPaint,
          paintAt: from,
          width: renderSize.height - from.dy,
          axis: Axis.vertical);
      canvas.drawCircle(from, 2, groundConnectorPaint);

      // 自定义底部的描述~
      // TextSpan span = TextSpan(text: "e??", style: TextStyle());
      // final TextPainter textPainter = TextPainter(
      //     text: span,
      //     textAlign: TextAlign.left,
      //     textDirection: TextDirection.ltr);
      // textPainter.layout();
      // var y = renderSize.height + param.param.renderEdge.bottom + ((param.param.bottomTextHeight - textPainter.height) / 2);
      // textPainter.paint(canvas,
      //     Offset(from.dx - textPainter.width / 2, y));
    });

    /// 最顶层
    //FIXME： 绘制在同一层并非是一个好主意 ,需要抽离出去
    if (shouldLocationInX != null) {
      // 画线
      canvas.drawLine(
          Offset(shouldLocationInX!, param.param.renderPadding.top),
          Offset(shouldLocationInX!,
              param.param.renderPadding.top + renderSize.height),
          locationInLinePaint);
      // 画点
      pointMap.forEach((key, value) {
        var pointPaint = Paint();
        pointPaint.strokeWidth = 1;
        pointPaint.color = Colors.white;
        canvas.drawCircle(key, 3, pointPaint);
        pointPaint.color = value.color;
        canvas.drawCircle(key, 2, pointPaint);
      });
    }
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
