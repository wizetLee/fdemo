import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer_line.dart';

class RichGraphRoute extends StatefulWidget {
  const RichGraphRoute({Key? key}) : super(key: key);

  @override
  State<RichGraphRoute> createState() => _RichGraphRouteState();
}

class _RichGraphRouteState extends State<RichGraphRoute> {
  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.zero;
    padding = EdgeInsets.fromLTRB(15, 15, 15, 15);
    var param = JZRichGraphParam(
        width: MediaQuery.of(context).size.width,
        height: 400,
        padding: padding,
        visibleCount: 100
        );

    List<JZRichGraphLineRendererValue> modelList = [];

    final now = DateTime.now();
    for (int i = 0; i < 100; i++) {
      final date = "${now.year}-${now.month}-${now.day + i}";
      final model = JZRichGraphLineRendererValue(value: Random().nextDouble(), date: date);
      modelList.add(model);
    }

    return Container(
        child: Column(
          children: [
            Container(
              height: 150,
            ),
            Container(
              // decoration: BoxDecoration(color: Colors.orange),
              child: JZRichGraph(
                param: param,
                renderer: JZRichGraphLineRenderer(models: modelList),
              ),
            ),
            Container(),
          ],
        ),
        color: Colors.white);
  }
}