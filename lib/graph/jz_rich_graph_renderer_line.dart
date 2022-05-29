import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';

class JZRichGraphLineRendererValue {
  double value;
  String date;
  JZRichGraphLineRendererValue({required this.value, required this.date});
}

/// 目前仅支持一条线
class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  /// 线的数据
  List<JZRichGraphLineRendererValue> models;

  int dividingRuleCount = 5;

  List<JZRGLinesPainterModel> painterModels = [];

  JZRichGraphLineRenderer({required this.models});

  @override
  List<TextSpan> getBottomRichText({required JZRichGraphRendererParam param}) {
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
      var lastText = models.last.date;
      if (models.length > param.param.visibleCount) {
        lastText = models[param.param.visibleCount - 1].date;
      }
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
  Widget getChartBG({required JZRichGraphRendererParam param}) {
    return CustomPaint(
      size: param.param.getRenderSize(),
      painter:
          JZLineBGPainter(count: 5, padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    );
  }

  @override
  Widget? getGestureRenderResult({required JZRichGraphRendererParam param}) {
    final models = this.models;
    final values = models.map((e) => e.value).toList();
    List<JZRGLinesPainterModel> painterModels = this.getPainterModels();

    var date = "--";
    var value = "--";
    final locationIn = param.locationIn;
    if (painterModels.isNotEmpty) {
      final painterModel = painterModels[0];
      if (locationIn != null && painterModel.lines.length > locationIn) {
        final model = painterModel.lines[locationIn];
        value = model.renderValue.toStringAsFixed(2);
        date = (model.origin as JZRichGraphLineRendererValue).date;
      } else if (painterModel.lines.length > (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        final model = painterModel.lines[index];
        value = model.renderValue.toStringAsFixed(2);
        date = (model.origin as JZRichGraphLineRendererValue).date;
      } else {
        final model = painterModel.lines.last;
        value = model.renderValue.toStringAsFixed(2);
        date = (model.origin as JZRichGraphLineRendererValue).date;
      }
    }
    print("手势的位置 = ${param.locationIn}");

    return Container(
        height: param.param.headerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                  fontSize: 18, decoration: TextDecoration.none),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18, decoration: TextDecoration.none),
            ),
          ],
        ));
  }

  @override
  TextSpan? getInfo({required JZRichGraphRendererParam param}) {
    // TODO: implement getInfo
    return null;
  }

  @override
  TextSpan? getInfoTitle({required JZRichGraphRendererParam param}) {
    // TODO: implement getInfoTitle
    return null;
  }

  @override
  TextSpan? getLatestInfo({required JZRichGraphRendererParam param}) {
    // TODO: implement getLatestInfo
    return null;
  }

  @override
  TextSpan? getLatestInfoTitle({required JZRichGraphRendererParam param}) {
    // TODO: implement getLatestInfoTitle
    return null;
  }

  @override
  List<TextSpan> getLeftRichText({required JZRichGraphRendererParam param}) {
    final range = JZRGLinesPainterModel.range(models: this.painterModels);
    // 获取所有数据的最值
    if (range == null) {
      return [const TextSpan(text: "--")];
    }

    double max = range.dy;
    double min = range.dx;
    final dataHeight = (max - min);
    final valuePerItem = (dataHeight / 4).abs();
    final title0 = max.toStringAsFixed(2);
    final title1 = (max - valuePerItem).toStringAsFixed(2);
    final title2 = (max - valuePerItem * 2).toStringAsFixed(2);
    final title3 = (max - valuePerItem * 3).toStringAsFixed(2);
    final title4 = (max - valuePerItem * 4).toStringAsFixed(2);

    return [
      TextSpan(text: "${title0}"),
      TextSpan(text: "${title1}"),
      TextSpan(text: "${title2}"),
      TextSpan(text: "${title3}"),
      TextSpan(text: "${title4}")
    ];
  }

  @override
  List<TextSpan> getRightRichText({required JZRichGraphRendererParam param}) {
    final range = JZRGLinesPainterModel.range(models: this.painterModels);
    // 获取所有数据的最值
    if (range == null) {
      return [const TextSpan(text: "--")];
    }

    double max = range.dy;
    double min = range.dx;
    final dataHeight = (max - min);
    final valuePerItem = (dataHeight / 4).abs();
    final title0 = max.toStringAsFixed(2);
    final title1 = (max - valuePerItem).toStringAsFixed(2);
    final title2 = (max - valuePerItem * 2).toStringAsFixed(2);
    final title3 = (max - valuePerItem * 3).toStringAsFixed(2);
    final title4 = (max - valuePerItem * 4).toStringAsFixed(2);

    return [
      TextSpan(text: "${title0}"),
      TextSpan(text: "${title1}"),
      TextSpan(text: "${title2}"),
      TextSpan(text: "${title3}"),
      TextSpan(text: "${title4}")
    ];
  }

  @override
  Widget? getRenderResult({required JZRichGraphRendererParam param}) {
    final models = this.models;
    final values = models.map((e) => e.value).toList();

    final targetCount = param.param.visibleCount;

    List<JZRGLinesPainterModel> painterModels = this.getPainterModels();
    this.painterModels = painterModels;
    final lpParam = JZRGLinesPainterParam()
      ..visibleCount = targetCount
      ..padding = param.param.renderPadding
      ..locationIn = param.locationIn;

    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZRGLinesPainter(models: painterModels, param: lpParam),
    );
  }

  List<JZRGLinesPainterModel> getPainterModels() {
    final models = this.models;
    // final values = models.map((e) => e.value).toList();
    List<JZRGLinesPainterModel> painterModels = [];
    {
      List<JZRGLinesPainterElement> elements = [];
      for (int i = 0; i < models.length; i++) {
        final element = JZRGLinesPainterElement(
            renderValue: models[i].value, origin: models[i]);
        elements.add(element);
      }
      final model = JZRGLinesPainterModel()
        ..color = Colors.yellow
        ..strokeWidth = 1
        ..lines = elements;

      painterModels.add(model);
    }
    return painterModels;
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

/// 绘制参数
class JZRGLinesPainterParam {
  int? visibleCount;
  int? locationIn;
  EdgeInsets padding = EdgeInsets.zero;

  JZRGLinesPainterParam();
}

/// 线段绘制
class JZRGLinesPainter extends CustomPainter {
  final List<JZRGLinesPainterModel> models;

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
    final renderSize = Size(
        size.width - param.padding.left - param.padding.right,
        size.height - param.padding.top - param.padding.bottom);

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

    final range = this.range();
    // 获取所有数据的最值
    if (range == null) {
      return;
    }

    double max = range.dy;
    double min = range.dx;

    if (kDebugMode) {
      print("最大值 = ${max} 最小值 = ${min}");
    }

    var didDrawLocationIn = false;

    var LocationInLinePaint = Paint()
      ..strokeWidth = 1
      ..color = Colors.red;

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
            {
              if (this.param.locationIn == i && (didDrawLocationIn == false)) {
                canvas.drawLine(Offset(startX, 0),
                    Offset(startX, renderSize.height), LocationInLinePaint);
                didDrawLocationIn = true;
              }
            }

            if (lines.length > i) {
              /// 得到绘制的坐标
              final y = (lines[i].renderValue / max) * renderSize.height +
                  param.padding.top;
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

  /// dx = min
  /// dy = max
  Offset? range() {
    return JZRGLinesPainterModel.range(models: this.models);
  }
}
