import 'dart:math';

import 'package:fdemo/jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal_value.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';
import 'package:fdemo/jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal.dart';

import '../jz_rich_graph_renderer_normal/jz_rich_graph_renderer_normal_entity.dart';

/// DEMO
class RichGraphDemoRoute extends StatefulWidget {
  const RichGraphDemoRoute({Key? key}) : super(key: key);

  @override
  State<RichGraphDemoRoute> createState() => _RichGraphDemoRouteState();
}

class _RichGraphDemoRouteState extends State<RichGraphDemoRoute> {
  List<JZRGLinesPainterModel> painterModels = [];
  int count = 20;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 250), () {
      final now = DateTime.now();

      List<JZRichGraphLineRendererNormalValue> lineList0 = [];
      List<JZRichGraphLineRendererNormalValue> lineList1 = [];
      for (int i = 0; i < count; i++) {
        final date = "${now.year}-${now.month}-${now.day + i}";
        {
          final model = JZRichGraphLineRendererNormalValue(
              value: (Random().nextInt(count).toDouble()) *
                  ((i % 2 == 0) ? 1 : -1),
              date: date);
          lineList0.add(model);
        }
        {
          final model = JZRichGraphLineRendererNormalValue(
            value:
                (Random().nextInt(count).toDouble()) * ((i % 2 == 0) ? 1 : -1),
            date: date,
          );
          lineList1.add(model);
        }
      }
      {
        var model = JZRGLinesPainterModel();
        model.color = Colors.lightBlueAccent;
        model.lines = lineList0
            .map((e) =>
                JZRGNormalPainterElement(origin: e, renderValue: e.value))
            .toList();
        painterModels.add(model);
      }
      {
        var model = JZRGLinesPainterModel();
        model.color = Colors.green;
        model.lines = lineList1
            .map((e) =>
                JZRGNormalPainterElement(origin: e, renderValue: e.value))
            .toList();
        painterModels.add(model);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.zero;
    padding = const EdgeInsets.fromLTRB(15, 15, 15, 15);
    var param = JZRichGraphParam(
      width: MediaQuery.of(context).size.width,
      height: 400,
      padding: padding,
      visibleCount: count,
      dividingRuleCount: 7,
      rangeClosure: (range) {
        if (range != null) {
          return Offset(range.dx, range.dy * 10);
        }
        return null;
      }
      // renderPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );

    return SingleChildScrollView(
      child: Container(
          height: 1000,
          child: Column(
            children: [
              Container(
                height: 150,
              ),
              Container(
                child: JZRichGraph(
                  param: param,
                  renderer:
                      JZRichGraphLineRenderer(painterModels: painterModels),
                ),
              ),
              Container(),
            ],
          ),
          color: Colors.white),
    );
  }
}
