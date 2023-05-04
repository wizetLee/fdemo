import 'dart:ui';

import 'package:fdemo/route/JZRouteManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui' as ui;

class AnnotateRoute extends StatefulWidget {
  const AnnotateRoute({Key? key}) : super(key: key);

  @override
  State<AnnotateRoute> createState() => _AnnotateRouteState();
}

class _AnnotateRouteState extends State<AnnotateRoute> {
  Image? uiimage;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                      onTap: () async {
                        // // 获取屏幕
                        //
                        //
                        // // Widget w =
                        // //     context.findAncestorWidgetOfExactType<MaterialApp>()
                        // //         as Widget;
                        // // print("w = ${w}");
                        //
                        // var navigator = JZRouteManager.instance.navigatorKey.currentState?.widget;
                        // print("navigator?.pages = ${navigator?.pages}");
                        //
                        // var context = JZRouteManager.instance.navigatorKey.currentContext;
                        // if (context == null) {
                        //   return;
                        // }
                        //
                        // // 这样是拿不到的
                        // // w.createElement().renderObject ??
                        // var findRenderObject = context.findRenderObject();
                        // if (findRenderObject == null) {
                        //   return;
                        // }
                        // RenderRepaintBoundary boundary =
                        //     findRenderObject as RenderRepaintBoundary;
                        //
                        // var pixelRatio =
                        //     MediaQuery.of(context).devicePixelRatio;
                        //
                        // ui.Image uiimage =
                        //     await boundary.toImage(pixelRatio: pixelRatio ?? 1);
                        // final pngBytes = await uiimage!
                        //     .toByteData(format: ImageByteFormat.png);
                        // var u = Image.memory(Uint8List.view(pngBytes!.buffer));
                        // this.uiimage = u;
                        // setState(() {});
                      },
                      child: Container(
                        color: Colors.green,
                        height: 50,
                        width: 50,
                      ));
                },
              ),
              if (uiimage != null) uiimage!,
            ],
          )),
    );
  }
}
