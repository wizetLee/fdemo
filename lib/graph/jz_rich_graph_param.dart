import 'package:flutter/material.dart';

import '../jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal_entity.dart';

/// 配置
class JZRichGraphParam {
  /// widget外边距
  EdgeInsets padding = EdgeInsets.zero;

  /// 绘图外边距
  EdgeInsets renderPadding = EdgeInsets.zero;

  /// 视图中数据的可视数量
  int visibleCount = 0;

  /// 绘图间隙，影响绘图区的renderSize的大小
  /// 默认 0 0 0 0
  EdgeInsets renderViewPadding;

  /// 显示刻度的数量（左右坐标轴）
  /// 默认 5
  int dividingRuleCount = 5;

  /// 刻度与renderView之间的关系处理
  double leftDividingRuleOffset; // 左边（0.0
  double rightDividingRuleOffset; // 右边（0.0
  double ruleGaps = 0;
  TextAlign leftDividingRuleAlignment = TextAlign.left;
  TextAlign rightDividingRuleAlignment = TextAlign.right;

  /// header 高度（40.0
  double headerHeight;

  /// header title 的固定宽度控制 （100.0
  double headerTitleWidth;

  /// render 与 header之间的高度
  double renderHeaderSpacing = 0;

  /// 底部3个text的高度（20.0
  double bottomTextHeight;

  /// 整个控件的宽度
  final double width;

  /// 整个控件的高度
  final double height;


  /// 获取最值
  /// dx = min
  /// dy = max
  Offset? range({required List<JZRGLinesPainterModel> models}) {
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
            if (tmpMax > max) {
              max = tmpMax;
            }
            if (min > tmpMin) {
              min = tmpMin;
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
    var result = Offset(min, max);
    if (rangeClosure != null) {
      return rangeClosure!.call(result);
    }
    return result;
  }
  Offset? Function(Offset?)? rangeClosure;

  JZRichGraphParam({
    required this.width,
    required this.height,
    this.padding = EdgeInsets.zero,
    this.renderPadding = EdgeInsets.zero,
    this.visibleCount = 0,
    this.renderViewPadding = EdgeInsets.zero,
    this.dividingRuleCount = 5,
    this.leftDividingRuleOffset = 0,
    this.rightDividingRuleOffset = 0,
    this.ruleGaps = 2.0,
    this.leftDividingRuleAlignment = TextAlign.left,
    this.rightDividingRuleAlignment = TextAlign.right,
    this.headerHeight = 40,
    this.headerTitleWidth = 100,
    this.renderHeaderSpacing = 0,
    this.bottomTextHeight = 20,
    this.rangeClosure,
  });

  /// 获取绘制区的尺寸
  /// 最大的绘图区（包括背景）
  Size getRenderSize() {
    return Size(
        width -
            padding.left -
            padding.right -
            leftDividingRuleOffset -
            rightDividingRuleOffset,
        height -
            padding.top -
            padding.bottom -
            bottomTextHeight -
            renderHeaderSpacing -
            headerHeight);
  }

  /// 除却renderPadding之后的绘图区
  Size getRealRenderSize() {
    final size = getRenderSize();
    return Size(size.width - renderPadding.left - renderPadding.right,
        size.height - renderPadding.top - renderPadding.bottom);
  }

  int getVisibleCount() {
    if (visibleCount > 0) {
      return visibleCount;
    }
    return 0;
  }
}
