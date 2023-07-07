import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:fdemo/jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'jz_rich_graph_renderer_normal_value.dart';
export 'package:fdemo/graph/jz_rich_graph_renderer.dart';

/// 目前仅支持一条线
class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  /// 线的数据
  List<JZRichGraphLineRendererNormalValue> models;

  List<JZRGLinesPainterModel> painterModels = [];

  JZRichGraphLineRenderer({required this.models});

  @override
  Widget getChartBG({required JZRichGraphRendererParam param}) {
    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZLineBGPainter(count: 5, padding: EdgeInsets.zero),
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
    List<JZRGLinesPainterModel> painterModels = this.getPainterModels();
    this.painterModels = painterModels;
    //FIXME:看情况自定义头部的widget
    return SizedBox(
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
          leftLabels.add(
              RichText(text: const TextSpan(text: "--"), textAlign: alignment));
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
  /// 获取底部展示的内容（日期）
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(text: first, textAlign: TextAlign.left),
          RichText(text: second, textAlign: TextAlign.center),
          RichText(text: third, textAlign: TextAlign.right)
        ],
      ),
    );
  }

  TextSpan? getInfo({required JZRichGraphRendererParam param}) {
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

    var count = param.param.dividingRuleCount;

    // 获取所有数据的最值
    if (range == null) {
      return [const TextSpan(text: "--")];
    }

    double max = range.dy;
    double min = range.dx;
    final dataHeight = (max - min);

    final valuePerItem = (dataHeight / (count - 1)).abs();
    List<TextSpan> result = [];
    for (var i = 0; i < count; i++) {
      var title = (max - (valuePerItem * i)).toStringAsFixed(2);
      result.add(TextSpan(text: "${title}"));
    }
    return result;
  }

  /// 左右坐标的富文本
  List<TextSpan> getRightRichText({required JZRichGraphRendererParam param}) {
    final range = JZRGLinesPainterModel.range(models: this.painterModels);
    var count = param.param.dividingRuleCount;

    // 获取所有数据的最值
    if (range == null) {
      return [const TextSpan(text: "--")];
    }

    double max = range.dy;
    double min = range.dx;
    final dataHeight = (max - min);

    final valuePerItem = (dataHeight / (count - 1)).abs();
    List<TextSpan> result = [];
    for (var i = 0; i < count; i++) {
      var title = (max - (valuePerItem * i)).toStringAsFixed(2);
      result.add(TextSpan(text: "${title}"));
    }
    return result;
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
