import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';

/// 渲染器
abstract class JZRichGraphRenderer {
  /// 背景
  Widget getChartBG(Size size);

  /// 绘图结果
  Widget? getRenderResult(Size size, JZRichGraphParam param);

  /// 手势时，覆盖在【绘图结果】之上的layer
  Widget? getGestureRenderResult(
      int locationIn, Offset point, Size size, JZRichGraphParam param);

  /// 最新的描述，InfoView右侧
  TextSpan? getLatestInfo();

  /// 标题/日期，InfoView左侧
  TextSpan? getLatestInfoTitle();

  /// 【手势操作时】最新的描述，InfoView右侧
  TextSpan? getInfo(int locationIn);

  /// 【手势操作时】标题/日期，InfoView左侧
  TextSpan? getInfoTitle(int locationIn);

  /// 左侧刻度数据
  List<TextSpan> getLeftRichText();

  /// 右侧侧刻度数据
  List<TextSpan> getRightRichText();

  /// 底部刻度数据
  List<TextSpan> getBottomRichText();

  void hideGestureUI();
}


