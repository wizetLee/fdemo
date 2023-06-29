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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        // onLongPressDown: (LongPressDownDetails details) {
        //   print("onLongPressDown detail = ${details}");
        // },
        // onLongPressCancel: () {
        //   print("onLongPressCancel");
        // },
        // onLongPress: () {
        //   print("onLongPress");
        // },
        // // onLongf
        // onLongPressUp: () {
        //   print("onLongPressUp");
        // },
        // onLongPressEnd: (LongPressEndDetails details) {
        //   print("onLongPressEnd detail = ${details}");
        // },

        //
        // onVerticalDragDown: (DragDownDetails details) { print("onVerticalDragDown detail = ${details}"); },
        // onVerticalDragStart: (DragStartDetails details) { print("onVerticalDragStart detail = ${details}"); },
        // onVerticalDragUpdate: (DragUpdateDetails details) { print("onVerticalDragUpdate detail = ${details}"); },
        // onVerticalDragEnd: (DragEndDetails details) { print("onVerticalDragEnd detail = ${details}"); },
        // onVerticalDragCancel: () { print("onVerticalDragCancel"); },

        // Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer,
        // and a $recognizer gesture recognizer will result in the $recognizer gesture recognizer being ignored,
        // since the other two will catch all drags.

        // onHorizontalDragDown: (DragDownDetails details) {
        //   print("onHorizontalDragDown detail = ${details}");
        //   details;
        // },
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

              var widgetRectLeft = Rect.fromLTWH(widgetPositionLeft.dx, 0,
                  widgetSizeLeft.width, widgetSizeLeft.height);
              var widgetRectRight = Rect.fromLTWH(widgetPositionRight.dx, 0,
                  widgetSizeRight.width, widgetSizeRight.height);

              // 可相互推动的情况

              var handledWidth = driverSize.width;
              var cWidth = constraints.maxWidth - handledWidth * 2;

              // leftScale = (leftDriver.frame.maxX - leftWall - handledWidth) / cWidth;
              // rightScale = (rightDriver.frame.minX - leftWall - handledWidth) / cWidth;


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
              } else if (isRightDriving && rightScale < leftScale) {

                print(
                    "cWidth = [${cWidth}] leftScale = ${leftScale}  rightScale = ${rightScale}");
                print("rightScale < leftScale = ${rightScale < leftScale}");
                leftScale = rightScale;
              }


              if (isLeftDriving) {
                //print("正在滑动左侧把手");
                setState(() {
                  var tmp = _leftDriverDx;
                  tmp += details.delta.dx;
                  // 间隔计算

                  _leftDriverDx = tmp;
                  _rightDriverDx = driverSize.width + rightScale * cWidth;
                });
              } else if (isRightDriving) {
                //print("正在滑动右侧把手");
                setState(() {
                  var tmp = _rightDriverDx;
                  tmp += details.delta.dx;
                  // 间隔计算

                  _rightDriverDx = tmp;
                  _leftDriverDx = leftScale * cWidth;
                });
              }
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

        // onPanDown: (DragDownDetails details) {
        //   print("onPanDown detail = ${details}");
        // },
        // onPanStart: (DragStartDetails details) {
        //   print("onPanStart detail = ${details}");
        //
        // },
        // onPanUpdate: (DragUpdateDetails details) {
        //   print("onPanUpdate detail = ${details}");
        //   //FIXME:
        //   setState(() {
        //     // _top += details.delta.dy;
        //     _left += details.delta.dx;
        //   });
        // },
        // onPanEnd: (DragEndDetails details) {
        //   print("onPanEnd detail = ${details}");
        // },
        // onPanCancel: () {
        //   print("onPanCancel");
        // },
        // scale is a supersetr of pan
        // onScaleStart: (ScaleStartDetails details) { print("onScaleStart detail = ${details}"); },
        // onScaleUpdate: (ScaleUpdateDetails details) { print("onScaleUpdate detail = ${details}"); },
        // onScaleEnd: (ScaleEndDetails details) { print("onScaleEnd detail = ${details}"); },
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
