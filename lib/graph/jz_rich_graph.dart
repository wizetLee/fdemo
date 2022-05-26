import 'package:flutter/material.dart';
import 'package:fdemo/graph/jz_rich_graph_renderer.dart';
import 'package:fdemo/graph/jz_rich_graph_render_widget.dart';

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
  EdgeInsets padding = EdgeInsets.zero;

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
  late JZRichGraphRenderWidget renderView = JZRichGraphRenderWidget(
    param: this.widget.param,
  );

  @override
  Widget build(BuildContext context) {
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
    return Container(
      height: this.widget.param.headerHeight,
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: SizedBox(width: 20),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          Container(
            child: SizedBox(width: 20),
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          //FOX<E: 
        ],
      ),
    );
  }

  /// 底部内容
  Widget _buildBody() {
    final param = widget.param;

    final EdgeInsets renderInset = EdgeInsets.fromLTRB(
        param.leftDividingRuleOffset,
        param.renderHeaderSpacing,
        param.rightDividingRuleOffset,
        0);
    final leftRightRule = _buildLeftRightRule();
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
                        children: [_buildRenderWidget()],
                      ),
                    ),
                    Positioned(child: leftRightRule[0], left: 0),
                    Positioned(child: leftRightRule[1], right: 0),
                    Positioned(
                      child: _buildBottom(),
                      left: param.leftDividingRuleOffset,
                      bottom: 0,
                    )
                  ],
                )))
      ],
    ));
  }
}

extension SubWidget on _JZRichGraphState {
  List<Widget> _buildLeftRightRule() {
    final param = widget.param;
    final getLeftRichText = this.widget.renderer.getLeftRichText();
    final getRightRichText = this.widget.renderer.getRightRichText();
    List<Widget> leftLabels = [];
    List<Widget> rightLabels = [];

    final dividingRuleCount = param.dividingRuleCount;
    for (int i = 0; i < dividingRuleCount; i++) {
      {
        final alignment = param.leftDividingRuleAlignment;
        if (getLeftRichText.length > i) {
          leftLabels.add(Container(
            child: RichText(
              text: getLeftRichText[i],
              textAlign: alignment,
            ),
          ));
        } else {
          leftLabels
              .add(RichText(text: TextSpan(text: "--"), textAlign: alignment));
        }
      }

      {
        final alignment = param.rightDividingRuleAlignment;
        if (getRightRichText.length > i) {
          rightLabels
              .add(RichText(text: getRightRichText[i], textAlign: alignment));
        } else {
          rightLabels
              .add(RichText(text: TextSpan(text: "--"), textAlign: alignment));
        }
      }
    }
    final height = param.getRenderSize().height;
    var dividingRuleLeft = Container(
      height: height,
      color: Colors.transparent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: leftLabels),
    );
    var dividingRuleRight = Container(
      height: height,
      color: Colors.transparent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rightLabels),
    );
    return [
      IgnorePointer(
        child: dividingRuleLeft,
        ignoring: true,
      ),
      IgnorePointer(child: dividingRuleRight, ignoring: true)
    ];
  }

  Widget _buildBottom() {
    final getBottomRichText = this.widget.renderer.getBottomRichText();
    final first = (getBottomRichText.isNotEmpty)
        ? getBottomRichText[0]
        : const TextSpan(text: "--");
    final second = (getBottomRichText.length > 1)
        ? getBottomRichText[1]
        : const TextSpan(text: "--");
    final third = (getBottomRichText.length > 2)
        ? getBottomRichText[2]
        : const TextSpan(text: "--");

    final width = this.widget.param.getRenderSize().width;
    return Container(
      width: width,
      alignment: Alignment.center,
      height: this.widget.param.bottomTextHeight,
      color: Colors.pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(text: first, textAlign: TextAlign.left),
          RichText(text: second, textAlign: TextAlign.center),
          RichText(text: third, textAlign: TextAlign.right)
        ],
      ),
    );
  }

  /// 绘图部分
  Widget _buildRenderWidget() {
    final renderSize = this.widget.param.getRenderSize();
    final visibleCount = this.widget.param.getVisibleCount();

    //this.widget.param.renderViewPadding

    final result =
        this.widget.renderer.getRenderResult(renderSize, this.widget.param);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.3)),
        width: renderSize.width,
        height: renderSize.height,
        child: Stack(
          children: [
            // 背景
            this.widget.renderer.getChartBG(renderSize),
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
        //(visibleCount - 1)
        print(detail.localPosition);
      },
      onLongPressCancel: () {},
      onLongPressDown: (detail) {
        print(detail.localPosition);
      },
      onLongPressStart: (detail) {
        print(detail.localPosition);
      },
      onLongPressMoveUpdate: (detail) {
        print(detail.localPosition);
        // this.widget.render.getGestureRenderResult(locationIn, point, size, param)
      },
      onLongPressUp: () {},
    );
  }

  int _index(Offset point) {
    var index = -1;
    final maxCount = this.widget.param.getVisibleCount();

    final size = this.widget.param.getRenderSize();
    final stride = size.width / maxCount;
    if ((point.dx >= 0.0) && (maxCount > 0)) {
      index = (point.dx / stride).floor();
      if (index >= maxCount) {
        index = maxCount - 1;
      }
    } else {
      index = 0;
    }

     {
    final info = this.widget.renderer.getInfo(index);
    if (info != null) {
      // self.setInfo(info.getDesc(), isGesture: true)
    }
     }
     {
       final info = this.widget.renderer.getInfoTitle(index);
       if (info != null) {
      // self.setInfoTitle(info.getDesc(), isGesture: true)
    }
     }

    if (size.width <= 0 || size.height <= 0) {
    } else {
      // if let gestureResultLayer = self.renderer?.getGestureRenderResult(index, point: point, size: size, param: self.param) {
      //     self.renderView.setGestureRenderResultLayer(gestureResultLayer)
      // }
    }

    return index;
  }


  void setInfoTitle(dynamic title, bool isGesture) {
        // self.infoView.setTitle(title, isGesture: isGesture)
    }
    
    void setInfo(dynamic title, bool isGesture) {
        // self.infoView.setInfo(title, isGesture: isGesture)
    }
}
