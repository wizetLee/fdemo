import 'dart:math';

import 'package:fdemo/graph/jz_rich_graph_renderer_lines/jz_rich_graph_renderer_lines_value.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer_lines/jz_rich_graph_renderer_lines.dart';

import 'jz_rich_graph_renderer_lines/jz_rg_lines_painter.dart';

/// DEMO
class RichGraphDemoRoute extends StatefulWidget {
  const RichGraphDemoRoute({Key? key}) : super(key: key);

  @override
  State<RichGraphDemoRoute> createState() => _RichGraphDemoRouteState();
}

class _RichGraphDemoRouteState extends State<RichGraphDemoRoute> {
  List<JZRGEachPainterModel> painterModels = [];
  int count = 20;
  var nextIntCount = 100;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), () {
      _reqData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.zero;
    padding = const EdgeInsets.fromLTRB(15, 15, 15, 15);
    var param = JZRichGraphParam(
        width: MediaQuery.of(context).size.width,
        height: 300,
        padding: padding,
        visibleCount: count,
        dividingRuleCount: 5,
        leftVerticalAxisRangeClosure: (range) {
          if (range != null) {
            return Offset(range.dx, range.dy);
          }
          return null;
        }
        // renderPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        );

    // return ListView.builder(itemBuilder: (context, index) {
    //   return JZRichGraph(
    //     param: param,
    //     renderer:
    //     JZRichGraphLinesRenderer(painterModels: painterModels),
    //   );
    // },
    // itemCount: 10,
    // );
    return SingleChildScrollView(
      child: Container(
          height: 2000,
          child: Column(
            children: [
              Container(
                height: 150,
              ),
              GestureDetector(
                  onTap: () {
                    _reqData();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.orange,
                    child: Text("刷新数据"),
                  )),
              Container(
                child: JZRichGraph(
                  param: param,
                  renderer:
                      JZRichGraphLinesRenderer(painterModels: painterModels),
                ),
              ),
              Container(),
            ],
          ),
          color: Colors.white),
    );
  }

  _reqData() {
    painterModels.clear();
    final now = DateTime.now();

    List<JZRichGraphLineRendererLinesValue> lineList0 = [];
    List<JZRichGraphLineRendererLinesValue> lineList1 = [];
    List<JZRichGraphLineRendererLinesValue> lineList2 = [];
    for (int i = 0; i < count; i++) {
      // var date =  now.millisecondsSinceEpoch / 1000;
      final date = "${now.year}-${now.month}-${now.day + i}";
      {
        final model = JZRichGraphLineRendererLinesValue(
            value: (Random().nextInt(nextIntCount).toDouble()) *
                ((i % 2 == 0) ? 1 : -1),
            date: date);
        lineList0.add(model);
      }
      {
        final model = JZRichGraphLineRendererLinesValue(
          value: (Random().nextInt(nextIntCount).toDouble()) *
              ((i % 2 == 0) ? 1 : -1),
          date: date,
        );
        lineList1.add(model);
      }
      {
        final model = JZRichGraphLineRendererLinesValue(
          value: (Random().nextInt(nextIntCount).toDouble()) *
              ((i % 2 == 0) ? 1 : -1),
          date: date,
        );
        lineList2.add(model);
      }
    }
    // {
    //   var model = JZRGEachPainterModel();
    //   model.style = JZRGEachPainterModelStyle.columnar;
    //   model.strokeWidth = 5;
    //   model.color = Colors.green;
    //   model.axisDirection = AxisDirection.right;
    //   model.elements = lineList1
    //       .map((e) => JZRGLinesPainterElement(origin: e, renderValue: e.value))
    //       .toList();
    //   painterModels.add(model);
    // }
    {
      var model = JZRGEachPainterModel();
      model.style = JZRGEachPainterModelStyle.positiveColumnar;
      model.strokeWidth = 5;
      model.color = Colors.yellow;
      model.axisDirection = AxisDirection.right;
      model.elements = lineList2
          .map((e) => JZRGLinesPainterElement(origin: e, renderValue: e.value))
          .toList();
      painterModels.add(model);
    }
    {
      var model = JZRGEachPainterModel();
      model.color = Colors.lightBlueAccent;
      model.axisDirection = AxisDirection.right;
      model.elements = lineList0
          .map((e) => JZRGLinesPainterElement(origin: e, renderValue: e.value))
          .toList();
      painterModels.add(model);
    }

    setState(() {});
  }
}
