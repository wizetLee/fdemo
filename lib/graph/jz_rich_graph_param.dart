
import 'package:flutter/material.dart';

enum JZRichGraphDividingRuleDistribution {
  /// 同dividingRuleCount位置
  center,

  /// 首个与最后一个的位置有做调整
  proportionally,
}

enum JZRichGraphHeaderType {
  /// 左侧title（内容）   右侧subtitle（时间）
  normal,
}

/// 配置
class JZRichGraphParam {
  /// widget外边距
  EdgeInsets padding = EdgeInsets.zero;

  /// 绘图外边距
  EdgeInsets renderPadding = EdgeInsets.zero;

  /// 视图中数据的可视数量
  int visibleCount = 0;

  /// 绘图间隙，影响绘图区的renderSize的大小
  /// 默认 1 1 1 1
  EdgeInsets renderViewPadding = const EdgeInsets.all(0);

  /// 显示刻度的数量（左右坐标轴）
  /// 默认 5
  int dividingRuleCount = 5;

  /// 左边刻度宽度
  double leftDividingRuleWidth = 40.0;

  /// 右边刻度宽度
  double rightDividingRuleWidth = 40.0;

  /// 刻度中text的高度
  double dividingRuleTextHeight = 20.0;

  /// 刻度中text与线的对齐方式
  JZRichGraphDividingRuleDistribution dividingRuleTextDistribution =
      JZRichGraphDividingRuleDistribution.center;

  /// 左边刻度与renderView之间的关系处理
  double leftDividingRuleOffset = 40.0;
  double rightDividingRuleOffset = 40.0;
  TextAlign leftDividingRuleAlignment = TextAlign.left;
  TextAlign rightDividingRuleAlignment = TextAlign.right;

  /// header 样式控制
  JZRichGraphHeaderType headerType = JZRichGraphHeaderType.normal;

  /// header 高度
  double headerHeight = 40.0;

  /// haeder title 的固定宽度控制
  double headerTitleWidth = 100.0;

  /// render 与 header之间的高度
  double renderHeaderSpacing = 0;

  /// 底部3个text的高度
  double bottomTextHeight = 20.0;

  /// 整个控件的宽度
  final double width;

  /// 整个控件的高度
  final double height;

  JZRichGraphParam({
    required this.width,
    required this.height,
    this.padding = const EdgeInsets.all(0),
    this.renderPadding = const EdgeInsets.all(0),
    this.visibleCount = 0,
    this.renderViewPadding = const EdgeInsets.all(0),
    this.dividingRuleCount = 5,
    this.leftDividingRuleWidth = 40.0,
    this.rightDividingRuleWidth = 40.0,
    this.dividingRuleTextHeight = 15,
    this.dividingRuleTextDistribution =
        JZRichGraphDividingRuleDistribution.center,
    this.leftDividingRuleOffset = 40,
    this.rightDividingRuleOffset = 40,
    this.leftDividingRuleAlignment = TextAlign.left,
    this.rightDividingRuleAlignment = TextAlign.right,
    this.headerType = JZRichGraphHeaderType.normal,
    this.headerHeight = 40,
    this.headerTitleWidth = 100,
    this.renderHeaderSpacing = 0,
    this.bottomTextHeight = 20,
  });

  /// 获取绘制区的尺寸
  /// 最大的绘图区（包括背景）
  Size getRenderSize() {
    return Size(
        this.width -
            this.padding.left -
            this.padding.right -
            this.leftDividingRuleOffset -
            this.rightDividingRuleOffset,
        this.height -
            this.padding.top -
            this.padding.bottom -
            this.bottomTextHeight -
            this.renderHeaderSpacing -
            this.headerHeight);
  }

  /// 除却renderPadding之后的绘图区
  Size getRealRenderSize() {
    final size = getRenderSize();
    return Size(size.width - this.renderPadding.left - this.renderPadding.right,
        size.height - this.renderPadding.top - this.renderPadding.bottom);
  }

  int getVisibleCount() {
    if (this.visibleCount > 0) {
      return this.visibleCount;
    }
    return 0;
  }
}
