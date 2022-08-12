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

  JZRichGraphRendererParam get rendererParam {
    final rendererParam = JZRichGraphRendererParam(param: this.widget.param);

    rendererParam.point = this.localPosition;
    {
      // Offset localPosition = this.localPosition ?? Offset(double.maxFinite, 0);
      // rendererParam.locationIn =
      //     this.locationIn ?? (_index(localPosition) ?? 0);
      rendererParam.locationIn = this.locationIn;
    }
    return rendererParam;
  }

  @override
  Widget build(BuildContext context) {
    print("build");
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
    return this.widget.renderer.getHeaderResult(param: this.rendererParam) ??
        Container();
  }

  /// 底部内容
  Widget _buildBody() {
    print("_buildBody");
    final param = widget.param;

    final EdgeInsets renderInset = EdgeInsets.fromLTRB(
        param.leftDividingRuleOffset,
        param.renderHeaderSpacing,
        param.rightDividingRuleOffset,
        0);
    final children = _buildRenderWidget();
    var leftRule =
        this.widget.renderer.getLeftRule(param: this.rendererParam) ??
            Container();
    var rightRule =
        this.widget.renderer.getRightRule(param: this.rendererParam) ??
            Container();
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Padding(
                      padding: renderInset,
                      child: Column(
                        children: [children],
                      ),
                    ),
                    Positioned(child: leftRule, left: 0),
                    Positioned(child: rightRule, right: 0),
                    Positioned(
                      child: this
                              .widget
                              .renderer
                              .getBottomResult(param: this.rendererParam) ??
                          Container(),
                      left: param.leftDividingRuleOffset,
                      bottom: 0,
                    )
                  ],
                )))
      ],
    ));
  }
}

extension _JZRichGraphStateSubWidget on _JZRichGraphState {
  /// 绘图部分
  Widget _buildRenderWidget() {
    print("_buildRenderWidget");
    final renderSize = this.widget.param.getRenderSize();
    final visibleCount = this.widget.param.getVisibleCount();

    //this.widget.param.renderViewPadding

    final result =
        this.widget.renderer.getRenderResult(param: this.rendererParam);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.3)),
        width: renderSize.width,
        height: renderSize.height,
        child: Stack(
          children: [
            // 背景
            this.widget.renderer.getChartBG(param: this.rendererParam),
            // 内容
            if (result != null) result,
            // 其他
          ],
        ),
      ),
      onTap: () {},
      onDoubleTap: () {},
      onLongPress: () {},
      onLongPressEnd: (detail) {
        _gestureAction(detail.localPosition, renderSize);
      },
      onLongPressCancel: () {
        _clean();
      },
      onLongPressStart: (detail) {
        _gestureAction(detail.localPosition, renderSize);
      },
      onLongPressMoveUpdate: (detail) {
        _gestureAction(detail.localPosition, renderSize);
      },
      onLongPressUp: () {
        _clean();
      },
    );
  }

  _clean() {
    this.localPosition = null;
    this.locationIn = null;
    this.setState(() {});
  }

  /// 收视统一调度
  _gestureAction(Offset localPosition, Size renderSize) {
    this.localPosition = localPosition;
    final locationIn = _index(localPosition);
    this.locationIn = locationIn;
    if (locationIn != null) {
      if (kDebugMode) {
        print("手势locationIn = ${locationIn}");
      }

      //FIXME: 考虑局部刷新
      // this.widget.renderer.getGestureRenderResult(
      //     locationIn, localPosition, renderSize, this.widget.param);
      this.setState(() {});
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
      // + (widthPerItem / 2)， 相当于取整场景下+0.5的处理
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
