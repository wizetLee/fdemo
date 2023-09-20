export 'package:fdemo/graph/jz_rich_graph_renderer.dart';
export 'package:fdemo/graph/jz_rich_graph_param.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_param.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';

/// 绘图工具
/// 包含手势滑动相关配置
class JZRichGraph extends StatefulWidget {
  final JZRichGraphParam param;

  final JZRichGraphRenderer renderer;

  const JZRichGraph({Key? key, required this.param, required this.renderer})
      : super(key: key);

  @override
  State<JZRichGraph> createState() => _JZRichGraphState();
}

class _JZRichGraphState extends State<JZRichGraph> {
  Offset? localPosition;
  int? locationIn;
  ValueNotifier<int?> locationInVN = ValueNotifier(null);

  late JZRichGraphRendererParam rendererParam =
      JZRichGraphRendererParam(param: this.widget.param)
        ..point = this.localPosition
        ..locationIn = this.locationIn;

  @override
  void dispose() {
    locationInVN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.renderer.build(context);
    return SizedBox(
      width: this.widget.param.width,
      height: this.widget.param.height,
      child: Container(
          padding: this.widget.param.padding,
          decoration: BoxDecoration(color: Colors.pink.withOpacity(0.5)),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            padding: this.widget.param.renderViewPadding,
            child: Column(
              children: [
                _bulidHeader(),
                _buildBody(),
              ],
            ),
          )),
    );
  }

  /// 头部内容
  Widget _bulidHeader() {
    // return widget.renderer.getHeaderResult(param: this.rendererParam) ??
    //     Container();
    return ValueListenableBuilder(
        valueListenable: locationInVN,
        builder: (context, value, child) {
          return widget.renderer.getHeaderResult(param: rendererParam) ??
              Container(
                height: rendererParam.param.headerHeight,
              );
        });
  }

  /// 底部内容
  Widget _buildBody() {
    final param = widget.param;
    final EdgeInsets renderInset = EdgeInsets.fromLTRB(
        param.leftDividingRuleOffset,
        param.renderHeaderSpacing,
        param.rightDividingRuleOffset,
        0);
    final children = _buildRenderWidget();
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Positioned(
                      child: this
                              .widget
                              .renderer
                              .getBottomResult(param: this.rendererParam) ??
                          Container(),
                      bottom: 0,
                    ),
                    Padding(
                      padding: renderInset,
                      child: Column(
                        children: [children],
                      ),
                    ),
                  ],
                )))
      ],
    ));
  }
}

extension _JZRichGraphStateSubWidget on _JZRichGraphState {
  /// 绘图部分
  Widget _buildRenderWidget() {
    final renderSize = widget.param.getRenderSize();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.3)),
        width: renderSize.width,
        height: renderSize.height,
        child: Stack(
          children: [
            widget.renderer.getChartBG(param: rendererParam),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                child: ValueListenableBuilder(
                    valueListenable: locationInVN,
                    builder: (context, value, child) {
                      final result =
                          widget.renderer.getRenderResult(param: rendererParam);
                      if (result != null) return result;
                      return Container();
                    }),
                onTapDown: (TapDownDetails details) {
                  if (_showPosition()) {
                    _clean();
                  } else {
                    _gestureAction(details.localPosition, renderSize);
                  }
                },
                onLongPressEnd: (LongPressEndDetails details) {
                  _gestureAction(details.localPosition, renderSize);
                },
                onLongPressStart: (LongPressStartDetails details) {
                  _gestureAction(details.localPosition, renderSize);
                },
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                  _gestureAction(details.localPosition, renderSize);
                },
                onLongPressUp: () {
                  // _clean();
                },
              ),
            ),
          ],
        ));
  }

  bool _showPosition() {
    return (localPosition != null);
  }

  void _clean() {
    localPosition = null;
    locationIn = null;
    rendererParam.point = localPosition;
    rendererParam.locationIn = locationIn;
    locationInVN.value = null;
  }

  /// 收视统一调度
  _gestureAction(Offset localPosition, Size renderSize) {
    this.localPosition = localPosition;
    final locationIn = _index(localPosition);
    this.locationIn = locationIn;
    rendererParam.point = localPosition;
    rendererParam.locationIn = locationIn;
    locationInVN.value = locationIn;
    if (kDebugMode && locationIn != null) {
      print("手势locationIn = ${locationIn}");
    }
  }

  int? _index(Offset point) {
    var index = -1;
    final maxCount = this.widget.param.getVisibleCount();
    final size = this.widget.param.getRealRenderSize();

    final widthPerItem = size.width / (maxCount - 1);
    final beginLeft = this.widget.param.renderPadding.left;
    if ((point.dx >= beginLeft) && (maxCount > 0)) {
      final dx = point.dx - beginLeft;
      index = ((dx + (widthPerItem / 2)) / widthPerItem).floor();
      if (index >= maxCount) {
        index = maxCount - 1;
      }
    } else {
      index = 0;
    }
    return index;
  }
}
