import 'package:fdemo/graph/bg_painter/jz_rg_background_painter.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer_lines/jz_rg_lines_painter.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import '../../graph/jz_rich_graph_renderer_lines/jz_rich_graph_renderer_lines_value.dart';
import '../jz_rg_painter_model.dart';
export 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

/// 多线段绘制
class JZRichGraphLinesRenderer extends JZRichGraphRenderer {
  List<JZRGEachPainterModel> painterModels;

  JZRichGraphLinesRenderer({required this.painterModels});

  @override
  void build(BuildContext context) {}

  @override
  Widget getChartBG({required JZRichGraphRendererParam param}) {
    final getLeftRichText = this.getLeftRichText(param: param);
    final getRightRichText = this.getRightRichText(param: param);
    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZRGBackgroundPainter(
          count: param.param.dividingRuleCount,
          padding: EdgeInsets.zero,
          left: getLeftRichText,
          right: getRightRichText,
          ruleGaps: param.param.ruleGaps),
    );
  }

  ValueNotifier<int?> locationInVN = ValueNotifier(null);

  @override
  Widget? getRenderResult({required JZRichGraphRendererParam param}) {
    return null;
  }

  @override
  Widget? getHeaderResult({required JZRichGraphRendererParam param}) {
    return SizedBox(
        height: param.param.headerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              //   child: FittedBox(
              // fit: BoxFit.scaleDown,
              // alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text.rich(getInfoTitle(param: param) ??
                    WidgetSpan(child: Container())),
                // )
              ),
            ),
            Text.rich(getInfo(param: param) ?? WidgetSpan(child: Container()))
          ],
        ));
  }

  @override
  Widget? getBottomResult({required JZRichGraphRendererParam param}) {
    return _buildBottom(param);
  }

  @override
  Widget? getGestureRenderResult({required JZRichGraphRendererParam param}) {
    return CustomPaint(
      size: param.param.getRenderSize(),
      // painter作为一个插件
      painter: JZRGLinesPainter(
        lineModels: painterModels,
        param: param,
      ),
    );
  }
}

extension _JZRichGraphLineRenderer on JZRichGraphLinesRenderer {
  /// 获取底部展示的内容（日期）
  List<TextSpan> getBottomRichText({required JZRichGraphRendererParam param}) {
    var painterModels = this.painterModels;
    List<JZRGLinesPainterElement> lines = [];
    painterModels.forEach((element) {
      if (element.elements.length > lines.length) {
        lines = element.elements;
      }
    });

    final models = lines
        .map((e) => e.origin as JZRichGraphLineRendererLinesValue)
        .toList();
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
    return null;
    var value = "--";
    final locationIn = param.locationIn;
    if (painterModels.isNotEmpty) {
      final painterModel = painterModels[0];
      if (locationIn != null && painterModel.elements.length > locationIn) {
        final model = painterModel.elements[locationIn];
        value = model.renderValue.toStringAsFixed(2);
      } else if (painterModel.elements.length >
          (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        final model = painterModel.elements[index];
        value = model.renderValue.toStringAsFixed(2);
      } else {
        if (painterModel.elements.isEmpty) {
          value = "--";
        } else {
          final model = painterModel.elements.last;
          value = model.renderValue.toStringAsFixed(2);
        }
      }
    }

    return TextSpan(
        text: value,
        style: const TextStyle(
          fontSize: 14,
        ),
        children: const [
          TextSpan(
            text: "",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]);
  }

  TextSpan? getInfoTitle({required JZRichGraphRendererParam param}) {
    List<InlineSpan> children = [];
    TextStyle textStyle = TextStyle(
      fontSize: 14,
    );

    var date = "--";
    final locationIn = param.locationIn;
    painterModels.forEach((element) {
      // 数据表示
      // 🟥⬛🟨🟦方框
      // 标题
      // 数据
      //FIXME: 因为只有一条线
      final painterModel = element;
      JZRGLinesPainterElement? model;
      if (locationIn != null && painterModel.elements.length > locationIn) {
        model = painterModel.elements[locationIn];

        date = (model.origin as JZRichGraphLineRendererLinesValue).date;
      } else if (painterModel.elements.length >
          (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        model = painterModel.elements[index];

        date = (model.origin as JZRichGraphLineRendererLinesValue).date;
      } else {
        if (painterModel.elements.isEmpty) {
          date = "--";
        } else {
          model = painterModel.elements.last;
          date = (model.origin as JZRichGraphLineRendererLinesValue).date;
        }
      }

      if (element.infoTitleClosure != null) {
        var span = element.infoTitleClosure!.call(model);
        children.add(span);
      } else {
        var block = WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  color: element.color,
                  borderRadius: BorderRadius.circular(2.0)),
            ));
        children.add(block);

        {
          var gap = WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: Container(width: 2, height: 2),
          );
          children.add(gap);
        }

        var title = TextSpan(text: element.infoTitle ?? "--", style: textStyle);
        children.add(title);

        if (model != null &&
            model.origin is JZRichGraphLineRendererLinesValue) {
          {
            var gap = WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Container(width: 2, height: 2),
            );
            children.add(gap);
          }

          var _textStyle = textStyle.copyWith(color: Colors.orange);
          var text = (model.origin as JZRichGraphLineRendererLinesValue)
              .value
              .toStringAsFixed(2);
          var value = TextSpan(text: text, style: _textStyle);
          children.add(value);
        }
        {
          var gap = WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: Container(width: 12, height: 12),
          );
          children.add(gap);
        }
      }
    });
    return TextSpan(style: textStyle, children: children);
  }

  List<TextSpan> getLeftRichText({required JZRichGraphRendererParam param}) {
    var range = param.param.rangeLeft(models: painterModels);
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
      result.add(TextSpan(text: title));
    }
    return result;
  }

  /// 左右坐标的富文本
  List<TextSpan> getRightRichText({required JZRichGraphRendererParam param}) {
    var range = param.param.rangeRight(models: painterModels);
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
      result.add(TextSpan(text: title));
    }
    return result;
  }
}
