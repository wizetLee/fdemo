import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer_line.dart';

/// DEMO
class RichGraphDemoRoute extends StatefulWidget {
  const RichGraphDemoRoute({Key? key}) : super(key: key);

  @override
  State<RichGraphDemoRoute> createState() => _RichGraphDemoRouteState();
}

class _RichGraphDemoRouteState extends State<RichGraphDemoRoute> {
  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.zero;
    int count = 10;
    padding = EdgeInsets.fromLTRB(15, 15, 15, 15);
    var param = JZRichGraphParam(
        leftDividingRuleOffset: 0,
      rightDividingRuleOffset: 0,
      // leftDividingRuleWidth: 0,
      // rightDividingRuleWidth: 0,
        width: MediaQuery.of(context).size.width,
        height: 400,
        padding: padding,
        visibleCount: count,
      // renderPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        );


    List<JZRichGraphLineRendererValue> modelList = [];

    final now = DateTime.now();
    for (int i = 0; i < count; i++) {
      final date = "${now.year}-${now.month}-${now.day + i}";
      final model = JZRichGraphLineRendererValue(
          value: Random().nextInt(count).toDouble(), date: date);
      modelList.add(model);
    }

    return SingleChildScrollView(child: Container(
      height: 1000,
        child: Column(
          children: [
            Container(
              height: 150,
            ),
            Container(
              child: JZRichGraph(
                param: param,
                renderer: JZRichGraphLineRenderer(models: modelList),
              ),
            ),
            Container(),
          ],
        ),
        color: Colors.white),);
  }
}
