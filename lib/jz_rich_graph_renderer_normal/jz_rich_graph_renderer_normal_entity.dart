import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// 绘制模型的单个数据
class JZRGNormalPainterElement {
  /// 原始数据
  dynamic origin;

  /// 用于绘制的数值
  double renderValue;

  JZRGNormalPainterElement({required this.renderValue, required this.origin});
}

/// 单个绘制模型的详细配置
class JZRGLinesPainterModel {
  /// 绘制模型
  List<JZRGNormalPainterElement> lines = [];

  Color color = Colors.red;

  double strokeWidth = 1;

  /// 获取最值
  /// dx = min
  /// dy = max
  static Offset? range({required List<JZRGLinesPainterModel> models}) {
    double? max;
    double? min;
    // 获取所有数据的最值
        {
      for (var element in models) {
        final renderValues = element.lines.map((e) => e.renderValue).toList();
        if (renderValues.isNotEmpty) {
          final tmpMax = renderValues
              .reduce((value, element) => (value > element) ? value : element);
          final tmpMin = renderValues
              .reduce((value, element) => (value < element) ? value : element);
          if (max != null && min != null) {
            if (max > tmpMax) {
              max = tmpMax;
            }
            if (min < tmpMax) {
              min = tmpMax;
            }
          } else {
            max = tmpMax;
            min = tmpMin;
          }
        }
      }
    }
    if (max == min) {
      return null;
    }

    if (max == null || min == null) {
      return null;
    }

    return Offset(min, max);
  }
}

/// 画板参数
class JZRGNormalPainterParam {
  int? visibleCount;
  int? locationIn;
  EdgeInsets padding = EdgeInsets.zero;
  JZRGNormalPainterParam();
}

/// 多段绘制模型的落地
class JZRGNormalPainter extends CustomPainter {

  /// 线的模型（可多条）
  final List<JZRGLinesPainterModel> lineModels;

  /// 绘制相关的参数
  JZRGNormalPainterParam param;

  JZRGNormalPainter({
    required this.lineModels,
    required this.param,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const color = Colors.orangeAccent;

    var paint = Paint()
      ..strokeWidth = 1
      ..color = color;

    var y = param.padding.top;
    var x = param.padding.left;
    final renderSize = Size(
        size.width - param.padding.left - param.padding.right,
        size.height - param.padding.top - param.padding.bottom);

    double startX = x;

    final models = this.lineModels;
    var maxLength = 0;
    {
      for (int i = 0; i < models.length; i++) {
        if (models[i].lines.length > maxLength) {
          maxLength = models[i].lines.length;
        }
      }
    }

    final visibleCount = this.param.visibleCount ?? maxLength;
    if (visibleCount <= 1) {
      return;
    }

    final widthPerItem = renderSize.width / (visibleCount - 1);
    canvas.drawLine(Offset(startX, 0), Offset(startX, 0), paint);

    final range = this.range();
    // 获取所有数据的最值
    if (range == null) {
      return;
    }

    double max = range.dy;
    double min = range.dx;

    /// 绘制的是数值
    var heightValue = max - min;
    var heightPerValue = renderSize.height / heightValue;

    if (kDebugMode) {
      print("最大值 = ${max} 最小值 = ${min}");
    }

    var didDrawLocationIn = false;

    var locationInLinePaint = Paint()
      ..strokeWidth = 1
      ..color = Colors.red;

    models.forEach((element) {
      // 每天线的绘制
      var linePaint = Paint()
        ..strokeWidth = element.strokeWidth
        ..color = element.color;

      final lines = element.lines;
      {
        // 位置计算
        if (element.lines.length > 1) {
          Offset? from;

          double? shouldLocationInX;
          for (int i = 0; i < visibleCount; i++) {
            {
              if (this.param.locationIn == i && (didDrawLocationIn == false)) {
                shouldLocationInX = startX;
                didDrawLocationIn = true;
              }
            }

            if (lines.length > i) {
              /// 得到绘制的坐标
              final y = (max - lines[i].renderValue) * heightPerValue;
              final to = Offset(startX, y);
              if (from != null) {
                // 绘制直线
                canvas.drawLine(from, to, linePaint);
                from = to;
              } else {
                from = to;
              }
              startX = startX + widthPerItem;
            }
          }

          if (shouldLocationInX != null) {
            canvas.drawLine(
                Offset(shouldLocationInX, param.padding.top),
                Offset(
                    shouldLocationInX, param.padding.top + renderSize.height),
                locationInLinePaint);
          }
        } else if (lines.length == 1) {
          //FIXME: 一个点的时候也需要处理

        }
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// dx = min
  /// dy = max
  Offset? range() {
    return JZRGLinesPainterModel.range(models: this.lineModels);
  }
}
