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

  /// 绘图结果
  Widget? getRenderResult({required JZRichGraphRendererParam param});

  /// 手势时，覆盖在【绘图结果】之上的layer
  Widget? getGestureRenderResult({required JZRichGraphRendererParam param});

  /// 最新的描述，InfoView右侧
  TextSpan? getLatestInfo({required JZRichGraphRendererParam param});

  /// 标题/日期，InfoView左侧
  TextSpan? getLatestInfoTitle({required JZRichGraphRendererParam param});

  /// 【手势操作时】最新的描述，InfoView右侧
  TextSpan? getInfo({required JZRichGraphRendererParam param});

  /// 【手势操作时】标题/日期，InfoView左侧
  TextSpan? getInfoTitle({required JZRichGraphRendererParam param});

  /// 左侧刻度数据
  List<TextSpan> getLeftRichText({required JZRichGraphRendererParam param});

  /// 右侧侧刻度数据
  List<TextSpan> getRightRichText({required JZRichGraphRendererParam param});

  /// 底部刻度数据
  List<TextSpan> getBottomRichText({required JZRichGraphRendererParam param});
}
