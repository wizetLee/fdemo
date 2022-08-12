import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';

class JZRichGraphRendererParam {
  JZRichGraphParam param;

  int? locationIn;
  Offset? point;

  JZRichGraphRendererParam({required this.param});
}

/// 渲染器
abstract class JZRichGraphRenderer {
  /// 背景
  Widget getChartBG({required JZRichGraphRendererParam param});

  /// 头部绘制的内容
  Widget? getHeaderResult({required JZRichGraphRendererParam param});

  /// 中部绘图结果
  Widget? getRenderResult({required JZRichGraphRendererParam param});

  /// 底部部绘图结果
  Widget? getBottomResult({required JZRichGraphRendererParam param});

  /// 左刻度
  Widget? getLeftRule({required JZRichGraphRendererParam param});

  /// 右刻度
  Widget? getRightRule({required JZRichGraphRendererParam param});
}
