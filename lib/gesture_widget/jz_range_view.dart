import 'package:flutter/material.dart';

/// 比例换算控制器
class JZRangeViewController {
  // - 外部写↓↓↓ ------

  void Function(double leftScale, double rightScale)? scaleDidChange;
  void Function(double leftScale, double rightScale)? setScale;

  // - 外部读↓↓↓ ------

  double Function()? getLeftScale;
  double Function()? getRightScale;

  double maxValue;
  double minValue;
  JZRangeViewController({required this.minValue, required this.maxValue}) :  assert(minValue <= maxValue);

  /// 通过「比例」设置计算当前「比例的值」
  /// 一般用在滑动组件时的换算
  double calDisplayValue({required double calScale}) {
    return _calDisplayValue(calScale: calScale, maxValue: maxValue, minValue: minValue);
  }

  /// 通过「比例的值」计算「比例」
  /// 一般用在初始值的换算
  double calScaleValue({required double calValue}) {
    return _calScaleValue(calValue: calValue, maxValue: maxValue, minValue: minValue);
  }

  double _calDisplayValue({required double calScale, required double maxValue, required double minValue}) {
    var _calScale = calScale;

    // 比例的内部矫正
    if (_calScale > 1) {
      _calScale = 1;
    } else if (_calScale < 0) {
      _calScale = 0;
    }

    var _maxValue = maxValue;
    var _minValue = minValue;

    var width = (_maxValue - _minValue);
    var displayValue = width * _calScale - _maxValue;
    return displayValue;
  }

  double _calScaleValue({required double calValue, required double maxValue, required double minValue}) {
    var _calValue = calValue;

    // 最值的内部矫正
    if (_calValue > maxValue) {
      _calValue = maxValue;
    } else if (_calValue < minValue) {
      _calValue = _calValue;
    }

    var width = (maxValue - minValue);
    var calScale = _calValue + maxValue / width;
    return calScale;
  }
}

class JZRangeView extends StatefulWidget {
  /// leftScale value range [0, 1], leftScale <= rightScale
  final double leftScale;

  /// rightScale value range [0, 1], leftScale <= rightScale
  final double rightScale;

  /// 移动把手的宽度
  final double? driverWidth;

  /// set a width for this widget, default is double.infinity
  final double? width;

  final double? height;

  final Widget Function(Size size)? leftDriver;
  final Widget Function(Size size)? rightDriver;
  final void Function(double leftScale, double rightScale)? scaleDidChange;

  final JZRangeViewController? controller;

  final EdgeInsets? padding;
  final EdgeInsets? margin;

  final Color? sliderBackgroundColor;
  final Color? sliderForegroundColor;
  final Color? background;

  const JZRangeView(
      {this.leftScale = 0.0,
        this.rightScale = 1.0,
        this.controller,
        this.scaleDidChange,
        this.width,
        this.height,
        this.leftDriver,
        this.rightDriver,
        this.driverWidth,
        this.padding,
        this.margin,
        this.sliderBackgroundColor,
        this.sliderForegroundColor,
        this.background,
        super.key})
      : assert(rightScale <= 1),
        assert(leftScale >= 0),
        assert(leftScale <= rightScale),
        assert((width != null) ? (width > 0) : true);

  @override
  State<JZRangeView> createState() => _JZRangeViewState();
}

class _JZRangeViewState extends State<JZRangeView> {
  GlobalKey leftDriverKey = GlobalKey(debugLabel: "leftDriverKeyDebugLabel");
  GlobalKey rightDriverKey = GlobalKey(debugLabel: "rightDriverKeyDebugLabel");
  GlobalKey gestureKey =
  GlobalKey(debugLabel: "_JZRangeViewStateGestureDebugLabel");
  final double _top = 0;
  double _leftDriverDx = 0;
  double _rightDriverDx = 0;
  late Size driverSize;
  bool isLeftDriving = false;
  bool isRightDriving = false;

  double leftScale = 0;
  double rightScale = 1;

  double sliderHeight = 2.0;

  finishDriving() {
    isLeftDriving = false;
    isRightDriving = false;
  }

  var firstLayout = false;

  double widgetWidth = 0.0;
  double height = 24.0;
  double driverWidth = 32.0;

  @override
  void initState() {
    super.initState();
    leftScale = widget.leftScale;
    rightScale = widget.rightScale;
    driverSize = Size(widget.driverWidth ?? driverWidth, height);
    padding = widget.padding;
    margin = widget.margin;

    widget.controller?.getLeftScale = () {
      return leftScale;
    };
    widget.controller?.getRightScale = () {
      return rightScale;
    };
    widget.controller?.setScale = (leftScale, rightScale) {
      assert(rightScale <= 1);
      assert(leftScale >= 0);
      assert(leftScale <= rightScale);
      this.leftScale = leftScale;
      this.rightScale = rightScale;
      setState(() {});
    };
  }

  EdgeInsets? padding;
  EdgeInsets? margin;
  Color get sliderBackgroundColor => Color(0xff000000);
  Color get sliderForegroundColor => Color(0xFFFD263F);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? height,
      width: widget.width,
      color: widget.background ?? Colors.transparent,
      // 考虑高度的设置
      child: Container(
        margin: margin,
        padding: padding,
        child: LayoutBuilder(builder: (context, constraints) {
          widgetWidth = constraints.maxWidth;
          var widgetHeight = constraints.maxHeight;
          driverSize = Size(driverSize.width, widgetHeight);

          // 位置计算
              {
            var handledWidth = driverSize.width;
            var cWidth = widgetWidth - handledWidth * 2;
            _leftDriverDx = leftScale * cWidth;
            _rightDriverDx = driverSize.width + rightScale * cWidth;
          }

          assert(widgetWidth != 0, "JZRangeView 布局出错 widgetWidth == 0");
          return GestureDetector(
            key: gestureKey,
            onHorizontalDragStart: (DragStartDetails details) {
              isLeftDriving = false;
              isRightDriving = false;
              {
                RenderBox? renderBox = leftDriverKey.currentContext
                    ?.findRenderObject() as RenderBox?;
                if (renderBox != null) {
                  Offset widgetPosition = renderBox.localToGlobal(Offset.zero,
                      ancestor: gestureKey.currentContext?.findRenderObject());
                  Size widgetSize = renderBox.size;
                  var widgetRect = Rect.fromLTWH(widgetPosition.dx, 0,
                      widgetSize.width, widgetSize.height);
                  var locationDx = Offset(details.localPosition.dx, 0);
                  if (widgetRect.contains(locationDx)) {
                    // 只计算x
                    isLeftDriving = true;
                  }
                }
                if (isLeftDriving == false) {
                  RenderBox? renderBox = rightDriverKey.currentContext
                      ?.findRenderObject() as RenderBox?;
                  if (renderBox != null) {
                    Offset widgetPosition = renderBox.localToGlobal(Offset.zero,
                        ancestor:
                        gestureKey.currentContext?.findRenderObject());
                    Size widgetSize = renderBox.size;
                    var widgetRect = Rect.fromLTWH(widgetPosition.dx, 0,
                        widgetSize.width, widgetSize.height);
                    if (widgetRect.contains(details.localPosition)) {
                      isRightDriving = true;
                    }
                  }
                }
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (isLeftDriving || isRightDriving) {
                RenderBox? renderBoxLeft = leftDriverKey.currentContext
                    ?.findRenderObject() as RenderBox?;
                RenderBox? renderBoxRight = rightDriverKey.currentContext
                    ?.findRenderObject() as RenderBox?;

                if (renderBoxLeft != null && renderBoxRight != null) {
                  Offset widgetPositionLeft = renderBoxLeft.localToGlobal(
                      Offset.zero,
                      ancestor: gestureKey.currentContext?.findRenderObject());
                  Size widgetSizeLeft = renderBoxLeft.size;
                  Offset widgetPositionRight = renderBoxRight.localToGlobal(
                      Offset.zero,
                      ancestor: gestureKey.currentContext?.findRenderObject());
                  Size widgetSizeRight = renderBoxRight.size;

                  var widgetRectLeft = Rect.fromLTWH(
                      widgetPositionLeft.dx +
                          (isLeftDriving ? details.delta.dx : 0),
                      0,
                      widgetSizeLeft.width,
                      widgetSizeLeft.height);
                  var widgetRectRight = Rect.fromLTWH(
                      widgetPositionRight.dx +
                          (isRightDriving ? details.delta.dx : 0),
                      0,
                      widgetSizeRight.width,
                      widgetSizeRight.height);

                  var handledWidth = driverSize.width;
                  var cWidth = widgetWidth - handledWidth * 2;
                  var leftScale =
                      (widgetRectLeft.right - handledWidth) / cWidth;
                  var rightScale =
                      (widgetRectRight.left - handledWidth) / cWidth;

                  if (leftScale < 0) {
                    leftScale = 0;
                  }
                  if (leftScale > 1) {
                    leftScale = 1;
                  }
                  if (rightScale < 0) {
                    rightScale = 0;
                  }
                  if (rightScale > 1) {
                    rightScale = 1;
                  }
                  if (isLeftDriving && leftScale > rightScale) {
                    rightScale = leftScale;
                    assert(leftScale <= rightScale);
                  } else if (isRightDriving && rightScale < leftScale) {
                    leftScale = rightScale;
                    assert(rightScale >= leftScale);
                  }
                  setState(() {
                    if (isLeftDriving || isRightDriving) {
                      this.leftScale = leftScale;
                      this.rightScale = rightScale;
                      var scaleDidChange = widget.controller?.scaleDidChange;
                      if (scaleDidChange != null) {
                        scaleDidChange(leftScale, rightScale);
                      }
                    }
                    // this.leftScale = leftScale;
                    // this.rightScale = leftScale;
                    // if (isLeftDriving) {
                    //   // var tmp = _leftDriverDx;
                    //   // tmp += details.delta.dx;
                    //   // _leftDriverDx = tmp;
                    //   _leftDriverDx = leftScale * cWidth;
                    //   _rightDriverDx = driverSize.width + rightScale * cWidth;
                    // } else if (isRightDriving) {
                    //   // var tmp = _rightDriverDx;
                    //   // tmp += details.delta.dx;
                    //   // _rightDriverDx = tmp;
                    //   _rightDriverDx = driverSize.width + rightScale * cWidth;
                    //   _leftDriverDx = leftScale * cWidth;
                    // }
                  });
                }
              }
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              finishDriving();
            },
            onHorizontalDragCancel: () {
              finishDriving();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: widgetHeight,
                      width: widgetWidth,
                      child: Center(
                        child: Container(
                          height: sliderHeight,
                          color: widget.sliderBackgroundColor ?? sliderBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: _leftDriverDx + driverSize.width / 2,
                    right: widgetWidth - _rightDriverDx - driverSize.width / 2,
                    child: SizedBox(
                      height: widgetHeight,
                      width: widgetWidth,
                      child: Center(
                        child: Container(
                          height: sliderHeight,
                          color: widget.sliderForegroundColor ?? sliderForegroundColor,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(_leftDriverDx, _top),
                    child: Container(
                      key: leftDriverKey,
                      width: driverSize.width,
                      height: driverSize.height,
                      color: Colors.transparent,
                      child: (widget.leftDriver != null)
                          ? widget.leftDriver!(driverSize)
                          : defaultLeftDriver(driverSize),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(_rightDriverDx, _top),
                    child: Container(
                      key: rightDriverKey,
                      width: driverSize.width,
                      height: driverSize.height,
                      color: Colors.transparent,
                      child: (widget.rightDriver != null)
                          ? widget.rightDriver!(driverSize)
                          : defaultRightDriver(driverSize),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _driverTip() {
    return Container(
      width: 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1), color: Color(0xff000000)),
    );
  }

  Widget defaultLeftDriver(Size size) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff000000),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.2),
              offset: Offset(0, 0),
              blurRadius: 4,
            ),
          ]),
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          _driverTip(),
          SizedBox(width: 2,),
          _driverTip(),
          SizedBox(width: 2,),
          _driverTip(),
          Spacer(),
        ],
      ),
    );
  }

  Widget defaultRightDriver(Size size) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff000000),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.2),
              offset: Offset(0, 0),
              blurRadius: 4,
            ),
          ]),
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          _driverTip(),
          SizedBox(width: 2,),
          _driverTip(),
          SizedBox(width: 2,),
          _driverTip(),
          Spacer(),
        ],
      ),
    );
  }
}
