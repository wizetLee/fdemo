import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'jz_rich_graph_renderer_normal_value.dart';

export 'package:fdemo/graph/jz_rich_graph_renderer.dart';

/// 目前仅支持一条线
class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  /// 线的数据
  List<JZRichGraphLineRendererNormalValue> models;

  int dividingRuleCount = 5;

  List<JZRGLinesPainterModel> painterModels = [];

  JZRichGraphLineRenderer({required this.models});

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
  Widget? getRenderResult({required JZRichGraphRendererParam param}) {
    final models = this.models;
    final values = models.map((e) => e.value).toList();

    final targetCount = param.param.visibleCount;

    List<JZRGLinesPainterModel> painterModels = this.painterModels;
    final lpParam = JZRGNormalPainterParam()
      ..visibleCount = targetCount
      ..padding = param.param.renderPadding
      ..locationIn = param.locationIn;

    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZRGNormalPainter(lineModels: painterModels, param: lpParam),
    );
  }

  @override
  Widget? getHeaderResult({required JZRichGraphRendererParam param}) {
    // final models = this.models;
    // final values = models.map((e) => e.value).toList();

    List<JZRGLinesPainterModel> painterModels = this.getPainterModels();
    this.painterModels = painterModels;
    print("手势的位置 = ${param.locationIn}");

    //FIXME: 分别在两侧的的内容
    return Container(
        height: param.param.headerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(getInfoTitle(param: param)!),
            Text.rich(getInfo(param: param)!)
          ],
        ));
  }

  @override
  Widget? getBottomResult({required JZRichGraphRendererParam param}) {
    return _buildBottom(param);
  }

  @override
  Widget? getLeftRule({required JZRichGraphRendererParam param}) {
    final getLeftRichText = this.getLeftRichText(param: param);
    List<Widget> leftLabels = [];
    final dividingRuleCount = param.param.dividingRuleCount;
    for (int i = 0; i < dividingRuleCount; i++) {
      {
        final alignment = param.param.leftDividingRuleAlignment;
        if (getLeftRichText.length > i) {
          leftLabels.add(Container(
            child: RichText(
              text: getLeftRichText[i],
              textAlign: alignment,
            ),
          ));
        } else {
          leftLabels
              .add(RichText(text: TextSpan(text: "--"), textAlign: alignment));
        }
      }
    }
    final height = param.param.getRenderSize().height;
    var dividingRuleLeft = Container(
      height: height,
      color: Colors.transparent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: leftLabels),
    );

    return IgnorePointer(child: dividingRuleLeft, ignoring: true);
  }

  @override
  Widget? getRightRule({required JZRichGraphRendererParam param}) {
    final getRightRichText = this.getRightRichText(param: param);
    List<Widget> rightLabels = [];

    final dividingRuleCount = param.param.dividingRuleCount;
    for (int i = 0; i < dividingRuleCount; i++) {
      {
        final alignment = param.param.rightDividingRuleAlignment;
        if (getRightRichText.length > i) {
          rightLabels
              .add(RichText(text: getRightRichText[i], textAlign: alignment));
        } else {
          rightLabels
              .add(RichText(text: TextSpan(text: "--"), textAlign: alignment));
        }
      }
    }
    final height = param.param.getRenderSize().height;
    var dividingRuleRight = Container(
      height: height,
      color: Colors.transparent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rightLabels),
    );
    return IgnorePointer(child: dividingRuleRight, ignoring: true);
  }
}

extension _JZRichGraphLineRenderer on JZRichGraphLineRenderer {
  /// 设置bottom显示的内容
  Widget _buildBottom(JZRichGraphRendererParam param) {
    print("_buildBottom");

    final getBottomRichText = this.getBottomRichText(param: param);
    final first = (getBottomRichText.isNotEmpty)
        ? getBottomRichText[0]
        : const TextSpan(text: "--");
    final second = (getBottomRichText.length > 1)
        ? getBottomRichText[1]
        : const TextSpan(text: "--");
    final third = (getBottomRichText.length > 2)
        ? getBottomRichText[2]
        : const TextSpan(text: "--");

    final width = param.param.getRenderSize().width;
    return Container(
      width: width,
      alignment: Alignment.center,
      height: param.param.bottomTextHeight,
      color: Colors.pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(text: first, textAlign: TextAlign.left),
          RichText(text: second, textAlign: TextAlign.center),
          RichText(text: third, textAlign: TextAlign.right)
        ],
      ),
    );
  }

  TextSpan? getInfo({required JZRichGraphRendererParam param}) {
    // List<JZRGLinesPainterModel> painterModels = this.getPainterModels();
    var value = "--";
    final locationIn = param.locationIn;
    if (painterModels.isNotEmpty) {
      final painterModel = painterModels[0];
      if (locationIn != null && painterModel.lines.length > locationIn) {
        final model = painterModel.lines[locationIn];
        value = model.renderValue.toStringAsFixed(2);
      } else if (painterModel.lines.length > (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        final model = painterModel.lines[index];
        value = model.renderValue.toStringAsFixed(2);
      } else {
        final model = painterModel.lines.last;
        value = model.renderValue.toStringAsFixed(2);
      }
    }

    return TextSpan(
        text: value,
        style: TextStyle(
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: "",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]);
  }

  TextSpan? getInfoTitle({required JZRichGraphRendererParam param}) {
    // List<JZRGLinesPainterModel> painterModels = this.getPainterModels();
    var date = "--";
    final locationIn = param.locationIn;
    if (painterModels.isNotEmpty) {
      final painterModel = painterModels[0];
      if (locationIn != null && painterModel.lines.length > locationIn) {
        final model = painterModel.lines[locationIn];
        date = (model.origin as JZRichGraphLineRendererNormalValue).date;
      } else if (painterModel.lines.length > (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        final model = painterModel.lines[index];
        date = (model.origin as JZRichGraphLineRendererNormalValue).date;
      } else {
        final model = painterModel.lines.last;
        date = (model.origin as JZRichGraphLineRendererNormalValue).date;
      }
    }
    return TextSpan(
        text: date,
        style: TextStyle(
          fontSize: 14,
        ),
        children: []);
  }

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

  /// 左右坐标的富文本
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

  List<JZRGLinesPainterModel> getPainterModels() {
    final models = this.models;
    // final values = models.map((e) => e.value).toList();
    List<JZRGLinesPainterModel> painterModels = [];
    {
      List<JZRGNormalPainterElement> elements = [];
      for (int i = 0; i < models.length; i++) {
        final element = JZRGNormalPainterElement(
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
