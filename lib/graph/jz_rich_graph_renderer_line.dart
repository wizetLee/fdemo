import 'dart:math';
import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_demo_graph.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/painting/text_span.dart';
import 'dart:ui';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';


class JZRichGraphLineRendererValue {
  double value;
  String date;
  JZRichGraphLineRendererValue({required this.value, required this.date});
}

class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  /// 线的数据
  List<JZRichGraphLineRendererValue> models;

  JZRichGraphLineRenderer({required this.models});

  @override
  List<TextSpan> getBottomRichText() {
    final models = this.models;
    if (models.isEmpty) {
      return [];
    }
    if (models.length == 1) {
      final text = models.first.date;
      return [
        const TextSpan(text: ""),
        TextSpan(text: text),
        const TextSpan(text: "")
      ];
    }
    // 数据量为偶数情况
    if (models.length == 2 || (models.length % 2 == 0)) {
      final firstText = models.first.date;
      final lastText = models.last.date;
      return [
        TextSpan(text: firstText),
        const TextSpan(text: ""),
        TextSpan(text: lastText)
      ];
    }
    int offset = ((models.length / 2).floor() + 1);
    return [
      TextSpan(text: models.first.date),
      TextSpan(text: models[offset].date),
      TextSpan(text: models.last.date)
    ];
  }

  @override
  Widget getChartBG(Size size) {
    // 绘制线段
    return CustomPaint(
      size: size,
      painter:
          JZLineBGPainter(count: 5, padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    );
  }

  @override
  Widget? getGestureRenderResult(
      int locationIn, Offset point, Size size, JZRichGraphParam param) {
    return null;
  }

  @override
  TextSpan? getInfo(int locationIn) {
    // TODO: implement getInfo
    return null;
  }

  @override
  TextSpan? getInfoTitle(int locationIn) {
    // TODO: implement getInfoTitle
    return null;
  }

  @override
  TextSpan? getLatestInfo() {
    // TODO: implement getLatestInfo
    return null;
  }

  @override
  TextSpan? getLatestInfoTitle() {
    // TODO: implement getLatestInfoTitle
    return null;
  }

  @override
  List<TextSpan> getLeftRichText() {
    return [const TextSpan(text: "--")];
  }

  @override
  Widget? getRenderResult(Size size, JZRichGraphParam param) {
    final models = this.models;
    final values = models.map((e) => e.value).toList();

    final targetCount = param.visibleCount;

    List<JZRGLinesPainterModel> painterModels = [];
    {
      //MARK: 临时数据
      List<JZRGLinesPainterElement> elements = [];
      for (int i = 0; i < values.length; i++) {
        final element = JZRGLinesPainterElement(
            renderValue: values[i], origin: null);
        elements.add(element);
      }
      final model = JZRGLinesPainterModel()
        ..color = Colors.yellow
        ..strokeWidth = 1
        ..lines = elements;

      painterModels.add(model);
    }


    final lpParam = JZRGLinesPainterParam()
    ..visibleCount = param.visibleCount
    ..padding = param.renderPadding
    ;
    return CustomPaint(
      size: size,
      painter:
          JZRGLinesPainter(models: painterModels, param: lpParam),
    );
  }

  @override
  List<TextSpan> getRightRichText() {
    return [const TextSpan(text: "--")];
  }

  @override
  void hideGestureUI() {
    // TODO: implement hideGestureUI
  }
}

/// 单个线段的数据的模型
class JZRGLinesPainterElement {
  /// 原始数据
  dynamic origin;

  /// 用于绘制的数值
  double renderValue;

  JZRGLinesPainterElement({required this.renderValue, required this.origin});
}

/// 线段样式的配置
class JZRGLinesPainterModel {
  List<JZRGLinesPainterElement> lines = [];

  Color color = Colors.red;

  double strokeWidth = 1;
}


/// 绘制参数
class JZRGLinesPainterParam {

  int? visibleCount;

  EdgeInsets padding = EdgeInsets.zero;

  JZRGLinesPainterParam();
}

/// 线段绘制
class JZRGLinesPainter extends CustomPainter {
  final List<JZRGLinesPainterModel> models;

  /// 可视的数据量
  //  int get visibleCount { return _visibleCount;}
  //  set visibleCount(int value) { }
  JZRGLinesPainterParam param;

  JZRGLinesPainter({
    required this.models,
    required this.param,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final color = Colors.orangeAccent;

    var paint = Paint()
      ..strokeWidth = 1
      ..color = color;

    var y = param.padding.top;
    var x = param.padding.left;
    final renderSize = Size(size.width - param.padding.left - param.padding.right, size.height - param.padding.top - param.padding.bottom);

    double startX = x;

    final models = this.models;
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

    double? max;
    double? min;
    // 获取所有数据的最值
    {
      models.forEach((element) {
        final renderValues = element.lines.map((e) => e.renderValue).toList();
        if (renderValues.length > 0) {
          final tmpMax = renderValues
              .reduce((value, element) => (value > element) ? value : element);
          final tmpMin = renderValues
              .reduce((value, element) => (value < element) ? value : element);
          if (max != null && min != null) {
            if (max! > tmpMax) {
              max = tmpMax;
            }
            if (min! < tmpMax) {
              min = tmpMax;
            }
          } else {
            max = tmpMax;
            min = tmpMin;
          }
        }
      });
    }

    if (max == min) {
      return;
    }

    if (max == null || min == null) {
      return;
    }

    models.forEach((element) {
      var linePaint = Paint()
        ..strokeWidth = element.strokeWidth
        ..color = element.color;

      final lines = element.lines;
      {
        // 位置计算
        if (element.lines.length > 1) {
          Offset? from = null;
          for (int i = 0; i < visibleCount; i++) {
            if (lines.length > i) {
              /// 得到绘制的坐标
              final y = (lines[i].renderValue / max!) * renderSize.height + param.padding.top;
              final to = Offset(startX, y);
              if (from != null) {
                canvas.drawLine(from, to, linePaint);
                from = to;
              } else {
                from = to;
              }
              startX = startX + widthPerItem;
            }
          }
        } else if (lines.length == 1) {}
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
