import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';

enum JZRichGraphDividingRuleDistribution {
  /// 同dividingRuleCount位置
  center,

  /// 首个与最后一个的位置有做调整
  proportionally,
}

enum JZRichGraphHeaderType {
  /// 左侧title（内容）   右侧subtitle（时间）
  normal,
}

/// 配置
class JZRichGraphParam {
  /// widget外边距
  EdgeInsets padding = EdgeInsets.zero;

  /// 绘图外边距
  EdgeInsets renderPadding = EdgeInsets.zero;

  /// 视图中数据的可视数量
  int visibleCount = 0;

  /// 绘图间隙，影响绘图区的renderSize的大小
  /// 默认 1 1 1 1
  EdgeInsets renderViewPadding = const EdgeInsets.all(0);

  /// 显示刻度的数量（左右坐标轴）
  /// 默认 5
  int dividingRuleCount = 5;

  /// 左边刻度宽度
  double leftDividingRuleWidth = 40.0;

  /// 右边刻度宽度
  double rightDividingRuleWidth = 40.0;

  /// 刻度中text的高度
  double dividingRuleTextHeight = 20.0;

  /// 刻度中text与线的对齐方式
  JZRichGraphDividingRuleDistribution dividingRuleTextDistribution =
      JZRichGraphDividingRuleDistribution.center;

  /// 左边刻度与renderView之间的关系处理
  double leftDividingRuleOffset = 40.0;
  double rightDividingRuleOffset = 40.0;
  TextAlign leftDividingRuleAlignment = TextAlign.left;
  TextAlign rightDividingRuleAlignment = TextAlign.right;

  /// header 样式控制
  JZRichGraphHeaderType headerType = JZRichGraphHeaderType.normal;

  /// header 高度
  double headerHeight = 40.0;

  /// haeder title 的固定宽度控制
  double headerTitleWidth = 100.0;

  /// render 与 header之间的高度
  double renderHeaderSpacing = 0;

  /// 底部3个text的高度
  double bottomTextHeight = 20.0;

  /// 整个控件的宽度
  final double width;

  /// 整个控件的高度
  final double height;

  JZRichGraphParam({
    required this.width,
    required this.height,
    this.padding = const EdgeInsets.all(0),
    this.renderPadding = const EdgeInsets.all(0),
    this.visibleCount = 0,
    this.renderViewPadding = const EdgeInsets.all(0),
    this.dividingRuleCount = 5,
    this.leftDividingRuleWidth = 40.0,
    this.rightDividingRuleWidth = 40.0,
    this.dividingRuleTextHeight = 15,
    this.dividingRuleTextDistribution =
        JZRichGraphDividingRuleDistribution.center,
    this.leftDividingRuleOffset = 40,
    this.rightDividingRuleOffset = 40,
    this.leftDividingRuleAlignment = TextAlign.left,
    this.rightDividingRuleAlignment = TextAlign.right,
    this.headerType = JZRichGraphHeaderType.normal,
    this.headerHeight = 40,
    this.headerTitleWidth = 100,
    this.renderHeaderSpacing = 0,
    this.bottomTextHeight = 20,
  });

  /// 获取绘制区的尺寸
  /// 最大的绘图区（包括背景）
  Size getRenderSize() {
    return Size(
        this.width -
            this.padding.left -
            this.padding.right -
            this.leftDividingRuleOffset -
            this.rightDividingRuleOffset,
        this.height -
            this.padding.top -
            this.padding.bottom -
            this.bottomTextHeight -
            this.renderHeaderSpacing -
            this.headerHeight);
  }

  /// 除却renderPadding之后的绘图区
  Size getRealRenderSize() {
    final size = getRenderSize();
    return Size(size.width - this.renderPadding.left - this.renderPadding.right,
        size.height - this.renderPadding.top - this.renderPadding.bottom);
  }

  int getVisibleCount() {
    if (this.visibleCount > 0) {
      return this.visibleCount;
    }
    return 0;
  }
}

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
    // final leftRightRule = _buildLeftRightRule();
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

      //FIXME: 局部刷新
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
      index = (dx / widthPerItem).floor();
      if (index >= maxCount) {
        index = maxCount - 1;
      }
    } else {
      index = 0;
    }

    // {
    //   final info = this.widget.renderer.getInfo(param: this.rendererParam);
    //   if (info != null) {
    //     // self.setInfo(info.getDesc(), isGesture: true)
    //   }
    // }
    // {
    //   final info = this.widget.renderer.getInfoTitle(param: this.rendererParam);
    //   if (info != null) {
    //     // self.setInfoTitle(info.getDesc(), isGesture: true)
    //   }
    // }

    // if (size.width <= 0 || size.height <= 0) {
    // } else {
    //   // if let gestureResultLayer = self.renderer?.getGestureRenderResult(index, point: point, size: size, param: self.param) {
    //   //     self.renderView.setGestureRenderResultLayer(gestureResultLayer)
    //   // }
    // }

    return index;
  }

  void setInfoTitle(dynamic title, bool isGesture) {
    // self.infoView.setTitle(title, isGesture: isGesture)
  }

  void setInfo(dynamic title, bool isGesture) {
    // self.infoView.setInfo(title, isGesture: isGesture)
  }
}
