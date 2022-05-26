import 'dart:math';

import 'package:fdemo/jz_line_bg_painter.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/painting/text_span.dart';
import 'dart:ui';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';


class JZRichGraphLineRendererValue {
  double value;
  String date;
  JZRichGraphLineRendererValue({required this.value, required this.date});
}


class JZRichGraphLineRenderer extends JZRichGraphRenderer {
  /// 线的数据
  List<JZRichGraphLineRendererValue> models;

  JZRichGraphLineRenderer({required this.models});

  @override
  List<TextSpan> getBottomRichText() {
    final models = this.models;
    if (models.isEmpty) {
      return [];
    }
    if (models.length == 1) {
      final text = models.first.date;
      return [const TextSpan(text: ""), TextSpan(text: text), const TextSpan(text: "")];
    }
    // 数据量为偶数情况
    if (models.length == 2 || (models.length % 2 == 0)) {
      final firstText = models.first.date;
      final lastText = models.last.date;
      return [TextSpan(text: firstText), const TextSpan(text: ""), TextSpan(text: lastText)];
    }
    int offset = ((models.length / 2).floor() + 1);
    return [TextSpan(text: models.first.date), TextSpan(text: models[offset].date), TextSpan(text: models.last.date)];
  }

  @override
  Widget getChartBG(Size size) {
    // 绘制线段
    return CustomPaint(
      size: size,
      painter: JZLineBGPainter(count: 5, padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    );
  }

  @override
  Widget? getGestureRenderResult(
      int locationIn, Offset point, Size size, JZRichGraphParam param) {
    final models = this.models;
    final values = models.map((e) => e.value);

    List<JZRGLinesPainterModel> painterModels = [];
    {
      //MARK: TEMP
      List<JZRGLinesPainterElement> elements = [];
      for (int i = 0; i < 100; i++) {
        final element = JZRGLinesPainterElement(renderValue: Random().nextDouble(), origin: null);
        elements.add(element);
      }
      final model = JZRGLinesPainterModel()
          ..color = Colors.yellow
          ..strokeWidth = 1
          ..lines = elements;
    }

    return CustomPaint(
      size: size,
      painter: JZRGLinesPainter(visibleCount: 100, models: painterModels),
    );

  }

  @override
  TextSpan? getInfo(int locationIn) {
    // TODO: implement getInfo
    return null;
  }

  @override
  TextSpan? getInfoTitle(int locationIn) {
    // TODO: implement getInfoTitle
    return null;
  }

  @override
  TextSpan? getLatestInfo() {
    // TODO: implement getLatestInfo
    return null;
  }

  @override
  TextSpan? getLatestInfoTitle() {
    // TODO: implement getLatestInfoTitle
    return null;
  }

  @override
  List<TextSpan> getLeftRichText() {
    return [const TextSpan(text: "--")];
  }

  @override
  Widget? getRenderResult(Size size, JZRichGraphParam param) {
    // TODO: implement getRenderResult
    return null;
  }

  @override
  List<TextSpan> getRightRichText() {
    return [const TextSpan(text: "--")];
  }

  @override
  void hideGestureUI() {
    // TODO: implement hideGestureUI
  }
}

class JZRGLinesPainterElement {
  /// 原始数据
  dynamic origin;

  /// 用于绘制的数值
  double renderValue;

  JZRGLinesPainterElement({required this.renderValue, required this.origin});
}

class JZRGLinesPainterModel {

  List<JZRGLinesPainterElement> lines = [];

  Color color = Colors.red;

  double strokeWidth = 1;
}

/// 线段绘制
class JZRGLinesPainter extends CustomPainter {

  final List<JZRGLinesPainterModel> models;

  /// 可视的数据量
  final int visibleCount;

  JZRGLinesPainter({
    required this.models,
    required this.visibleCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final color = Colors.orangeAccent;

    var paint = Paint()
      ..strokeWidth = 1
      ..color = color;

    double startX = 0;

    canvas.drawLine(Offset(startX, 0), Offset(startX, 0), paint);

    final models = this.models;
    models.forEach((element) {
      var linePaint = Paint();
      {
        // 位置计算
        final renderValues = element.lines.map((e) => e.renderValue);
        for (int i = 0; i < visibleCount; i++) {
          if (element.lines.length > i) {
            // canvas.drawLine(p1, p2, linePaint);
          }
        }
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
