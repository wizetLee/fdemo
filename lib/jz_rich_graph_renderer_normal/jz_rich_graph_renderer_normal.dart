import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:fdemo/jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'jz_rich_graph_renderer_normal_value.dart';
export 'package:fdemo/graph/jz_rich_graph_renderer.dart';

/// 目前仅支持一条线
class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  List<JZRGLinesPainterModel> painterModels;

  JZRichGraphLineRenderer({required this.painterModels});

  @override
  void build(BuildContext context) {
  }

  @override
  Widget getChartBG({required JZRichGraphRendererParam param}) {
    final getLeftRichText = this.getLeftRichText(param: param);
    final getRightRichText = this.getRightRichText(param: param);
    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZLineBGPainter(
          count: param.param.dividingRuleCount,
          padding: EdgeInsets.zero,
          left: getLeftRichText,
          right: getRightRichText,
          ruleGaps: param.param.ruleGaps),
    );
  }

  @override
  Widget? getRenderResult({required JZRichGraphRendererParam param}) {
    List<JZRGLinesPainterModel> painterModels = this.painterModels;
    return CustomPaint(
      size: param.param.getRenderSize(),
      painter: JZRGNormalPainter(lineModels: painterModels, param: param, ),
    );
  }

  @override
  Widget? getHeaderResult({required JZRichGraphRendererParam param}) {
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
}

extension _JZRichGraphLineRenderer on JZRichGraphLineRenderer {
  /// 获取底部展示的内容（日期）
  List<TextSpan> getBottomRichText({required JZRichGraphRendererParam param}) {
    var painterModels = this.painterModels;
    List<JZRGNormalPainterElement> lines = [];
    painterModels.forEach((element) {
      if (element.lines.length > lines.length) {
        lines = element.lines;
      }
    });

    final models = lines.map((e) => e.origin as JZRichGraphLineRendererNormalValue).toList();
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
        if (painterModel.lines.isEmpty) {
          value = "--";
        } else {
          final model = painterModel.lines.last;
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
    var date = "--";
    final locationIn = param.locationIn;
    if (painterModels.isNotEmpty) {
      //FIXME: 因为只有一条线
      final painterModel = painterModels[0];
      if (locationIn != null && painterModel.lines.length > locationIn) {
        final model = painterModel.lines[locationIn];
        date = (model.origin as JZRichGraphLineRendererNormalValue).date;
      } else if (painterModel.lines.length > (param.param.visibleCount - 1)) {
        final index = param.param.visibleCount - 1;
        final model = painterModel.lines[index];
        date = (model.origin as JZRichGraphLineRendererNormalValue).date;
      } else {
        if (painterModel.lines.isEmpty) {
          date = "--";
        } else {
          final model = painterModel.lines.last;
          date = (model.origin as JZRichGraphLineRendererNormalValue).date;
        }
      }
    }
    return TextSpan(
        text: date,
        style: const TextStyle(
          fontSize: 14,
        ),
        children: const []);
  }

  List<TextSpan> getLeftRichText({required JZRichGraphRendererParam param}) {
    var range = param.param.range(models: painterModels);
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
    var range = param.param.range(models: painterModels);
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
