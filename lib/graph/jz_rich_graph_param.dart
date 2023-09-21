import 'package:flutter/material.dart';
import 'jz_rg_painter_model.dart';
import 'jz_rich_graph_renderer_lines/jz_rg_lines_painter.dart';
import 'dart:math' as math;
export 'jz_rg_painter_model.dart';

/// 配置
class JZRichGraphParam {
  /// widget外边距
  EdgeInsets padding = EdgeInsets.zero;

  /// 绘图外边距
  EdgeInsets renderPadding = EdgeInsets.zero;

  /// 绘图内边距 EdgeInsets.symmetric(vertical: 5, horizontal: 5)
  EdgeInsets renderEdge;

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

  /// 是否需要接地线（目前的使用场景是，打板助手-市场情绪
  var needGroundConnector = false;


  /// 获取最值
  /// dx = min
  /// dy = max
  Offset? rangeLeft({required List<JZRGEachPainterModel> models}) {
    double? max;
    double? min;
    // 获取所有数据的最值
        {
      for (var element in models) {
        if (element.axisDirection != AxisDirection.left) {
          continue;
        }
        final renderValues = element.elements.map((e) => e.renderValue).toList();
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
    if (max != null && max == min) {
      min = (min! - max!);
    }

    if (max == null || min == null) {
      return null;
    }

    for (var element in models) {
      if (element.style == JZRGEachPainterModelStyle.columnar) {
        var _max = math.max(min!.abs(), max!.abs());
        max = _max;
        min = -_max;
        // 数据对称处理
        break;
      }
    }
    var result = Offset(min!, max!);
    if (rangeLeftClosure != null) {
      return rangeLeftClosure!.call(result);
    }
    return result;
  }
  Offset? rangeRight({required List<JZRGEachPainterModel> models}) {
    double? max;
    double? min;
    // 获取所有数据的最值
        {
      for (var element in models) {
        if (element.axisDirection != AxisDirection.right) {
          continue;
        }
        final renderValues = element.elements.map((e) => e.renderValue).toList();
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
    if (max != null && max == min) {
      min = (min! - max!);
    }

    if (max == null || min == null) {
      return null;
    }

    for (var element in models) {
      if (element.style == JZRGEachPainterModelStyle.columnar) {
        var _max = math.max(min!.abs(), max!.abs());
        max = _max;
        min = -_max;
        // 数据对称处理
        break;
      }
    }
    var result = Offset(min!, max!);
    if (rangeRightClosure != null) {
      return rangeRightClosure!.call(result);
    }
    return result;
  }
  Offset? Function(Offset?)? rangeLeftClosure;
  Offset? Function(Offset?)? rangeRightClosure;

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
    this.rangeLeftClosure,
    this.rangeRightClosure,
    this.renderEdge = const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
