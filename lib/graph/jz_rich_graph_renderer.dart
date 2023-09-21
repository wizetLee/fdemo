import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';

class JZRichGraphRendererParam {
  JZRichGraphParam param;

  int? locationIn;
  Offset? point;

  JZRichGraphRendererParam({required this.param});
}

// 2023年 7月 7日 星期五 08时45分59秒 CST
// TextPainter替换renderer中坐标，

/// 渲染器
abstract class JZRichGraphRenderer {

  void build(BuildContext context);

  /// 背景
  Widget getChartBG({required JZRichGraphRendererParam param});

  /// 头部绘制的内容
  Widget? getHeaderResult({required JZRichGraphRendererParam param});

  /// 中部绘图结果
  Widget? getRenderResult({required JZRichGraphRendererParam param});

  /// 中部手势变动绘图结果
  Widget? getGestureRenderResult({required JZRichGraphRendererParam param});

  /// 底部部绘图结果
  Widget? getBottomResult({required JZRichGraphRendererParam param});

}
