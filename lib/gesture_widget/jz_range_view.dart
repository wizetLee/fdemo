import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class JZRangeView extends StatefulWidget {
  const JZRangeView({super.key});

  @override
  State<JZRangeView> createState() => _JZRangeViewState();
}

class _JZRangeViewState extends State<JZRangeView> {
  double _top = 0;
  double _leftDriverDx = 0;
  double _rightDriverDx = 0;
  Size driverSize = Size(30, 28);
  late Size leftDriver = driverSize;
  late Size rightDriver = driverSize;
  GlobalKey leftDriverKey = GlobalKey(debugLabel: "leftDriverKeyDebugLabel");
  GlobalKey rightDriverKey = GlobalKey(debugLabel: "rightDriverKeyDebugLabel");
  bool isLeftDriving = false;
  bool isRightDriving = false;

  finishDriving() {
    isLeftDriving = false;
    isRightDriving = false;
  }

  var firstLayout = false;

  @override
  void initState() {
    super.initState();


    // 如何计算初始的位置
    // var cWidth = constraints.maxWidth - handledWidth * 2;
    // var leftScale = (widgetRectLeft.right - handledWidth) / cWidth;
    // var rightScale = (widgetRectRight.left - handledWidth) / cWidth;
    // leftScale = 10;
    // _leftDriverDx = leftScale * cWidth;
    // _rightDriverDx = driverSize.width + rightScale * cWidth;

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // constraints.maxWidth
      // if (firstLayout == false) {
      //
      // }
      return GestureDetector(
        onHorizontalDragStart: (DragStartDetails details) {
          isLeftDriving = false;
          isRightDriving = false;
          {
            RenderBox? renderBox =
                leftDriverKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
              Size widgetSize = renderBox.size;
              var widgetRect = Rect.fromLTWH(
                  widgetPosition.dx, 0, widgetSize.width, widgetSize.height);
              if (widgetRect.contains(details.localPosition)) {
                isLeftDriving = true;
              }
            }
          }

          if (isLeftDriving == false) {
            RenderBox? renderBox =
                rightDriverKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
              Size widgetSize = renderBox.size;
              var widgetRect = Rect.fromLTWH(
                  widgetPosition.dx, 0, widgetSize.width, widgetSize.height);
              if (widgetRect.contains(details.localPosition)) {
                isRightDriving = true;
              }
            }
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          print("onHorizontalDragUpdate detail = ${details}");

          if (isLeftDriving || isRightDriving) {
            RenderBox? renderBoxLeft =
                leftDriverKey.currentContext?.findRenderObject() as RenderBox?;
            RenderBox? renderBoxRight =
                rightDriverKey.currentContext?.findRenderObject() as RenderBox?;

            if (renderBoxLeft != null && renderBoxRight != null) {
              Offset widgetPositionLeft =
                  renderBoxLeft.localToGlobal(Offset.zero);
              Size widgetSizeLeft = renderBoxLeft.size;
              Offset widgetPositionRight =
                  renderBoxRight.localToGlobal(Offset.zero);
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
              var cWidth = constraints.maxWidth - handledWidth * 2;

              var leftScale = (widgetRectLeft.right - handledWidth) / cWidth;
              var rightScale = (widgetRectRight.left - handledWidth) / cWidth;
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
                if (isLeftDriving) {
                  // var tmp = _leftDriverDx;
                  // tmp += details.delta.dx;
                  // _leftDriverDx = tmp;
                  _leftDriverDx = leftScale * cWidth;
                  _rightDriverDx = driverSize.width + rightScale * cWidth;
                } else if (isRightDriving) {
                  // var tmp = _rightDriverDx;
                  // tmp += details.delta.dx;
                  // _rightDriverDx = tmp;
                  _rightDriverDx = driverSize.width + rightScale * cWidth;
                  _leftDriverDx = leftScale * cWidth;
                }
              });
            }
          }
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          print("onHorizontalDragEnd detail = ${details}");
          details;
          finishDriving();
        },
        onHorizontalDragCancel: () {
          print("onHorizontalDragCancel");
          finishDriving();
        },
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.orange,
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(_leftDriverDx, _top),
                child: Container(
                  key: leftDriverKey,
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                ),
              ),

              Transform.translate(
                offset: Offset(_rightDriverDx, _top),
                child: Container(
                  key: rightDriverKey,
                  width: 30,
                  height: 30,
                  color: Colors.red,
                ),
              )
              // Positioned(
              //     left: viewPosition.dx,
              //     child: Container(
              //       width: 30,
              //       height: 30,
              //       color: Colors.green,
              //     ))
            ],
          ),
        ),
      );
    });
  }
}
