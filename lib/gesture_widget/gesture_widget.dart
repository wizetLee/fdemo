import 'package:fdemo/gesture_widget/jz_range_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
class GestureWidget extends StatefulWidget {
  const GestureWidget({Key? key}) : super(key: key);

  @override
  State<GestureWidget> createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  var title = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: _scaffoldBody(context),
    );
  }

  JZRangeViewController rangeController = JZRangeViewController();

  var leftScaleValue = "";
  var rightScaleValue = "";
  var leftDisplayValue = "";
  var rightDisplayValue = "";

  @override
  void initState() {
    super.initState();
    var maxValue = 101.0;
    var minValue = -101.0;
    rangeController.scaleDidChange = (leftScale, rightScale){
      print("滑动变化： leftScale = ${leftScale}, rightScale = ${leftScale}");
      rightScaleValue = "${rightScale}";
      leftScaleValue = "${leftScale}";

      var width = (maxValue - minValue);
      var leftValue = width * leftScale - maxValue;
      var rightValue = width * rightScale - maxValue;
      var rightDisplayValue = "${rightValue}";
      var leftDisplayValue = "${leftValue}";
      if (leftValue == maxValue || leftValue == minValue) {
        leftDisplayValue = "无限";
      }
      if (rightValue == maxValue || rightValue == minValue) {
        rightDisplayValue = "无限";
      }

      this.rightDisplayValue = rightDisplayValue;
      this.leftDisplayValue = leftDisplayValue;
      // rightDisplayValue = "${rightScale}";
      // leftDisplayValue = "${leftScale}";
      // type 1 （  无限 - n   0  n 无限


      setState(() {

      });
    };
    //rangeController.setScale
  }
}

extension _TemplateRouteStateWidget on _GestureWidgetState {


  PreferredSizeWidget? _appBar() {
    return null;
  }

  Widget _scaffoldBody(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Center(
        child: Listener(
          // onPointerDown: (PointerDownEvent event) { print("onPointerDown = ${event}"); },
          // onPointerMove: (PointerMoveEvent event) {
          //   print("onPointerMove = ${event}");
          //   },
          // onPointerUp: (PointerUpEvent event) { print("onPointerUp = ${event}"); },
          // onPointerHover: (PointerHoverEvent event) { print("onPointerHover = ${event}"); },
          // onPointerCancel: (PointerCancelEvent event) { print("onPointerCancel = ${event}"); },
          // onPointerPanZoomStart: (PointerPanZoomStartEvent event) { print("onPointerPanZoomStart = ${event}"); },
          // onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent event) { print("onPointerPanZoomUpdate = ${event}"); },
          // onPointerPanZoomEnd: (PointerPanZoomEndEvent event) { print("onPointerPanZoomEnd = ${event}"); },
          // onPointerSignal: (PointerSignalEvent event) {
          //   print("onPointerSignal = ${event}");
          //   },
          child: Column(children: [
            SizedBox(height: 200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(leftDisplayValue), Text(rightDisplayValue),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(leftScaleValue), Text(rightScaleValue),
            ],),
            JZRangeView(
              leftScale: 0.5,
              rightScale: 1,
              controller: rangeController,
              leftDriver: (size) {
                return Container(
                  color: Colors.orange,
                  width: size.width,
                  height: size.height,
                );
              },
              rightDriver: (size) {
                return Container(
                  color: Colors.green,
                  width: size.width,
                  height: size.height,
                );
              },
              // padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              // padding: EdgeInsets.only(left: 10, right: 10),
              // width: 300,
            ),
          ],),
          // child: GestureDetector(
          //   onTapDown: (TapDownDetails details) {
          //     print("onTapDown detail = ${details}");
          //   },
          //   onTapUp: (TapUpDetails details) {
          //     print("onTapUp detail = ${details}");
          //   },
          //   onTap: () {
          //     print("onTap");
          //   },
          //   onTapCancel: () {
          //     print("onTapCancel");
          //   },
          //   onSecondaryTap: () {
          //     print("onSecondaryTap");
          //   },
          //   onSecondaryTapDown: (TapDownDetails details) {
          //     print("onSecondaryTapDown detail = ${details}");
          //   },
          //   onSecondaryTapUp: (TapUpDetails details) {
          //     print("onSecondaryTapUp detail = ${details}");
          //   },
          //   onSecondaryTapCancel: () {
          //     print("onSecondaryTapCancel");
          //   },
          //   onTertiaryTapDown: (TapDownDetails details) {
          //     print("onTertiaryTapDown detail = ${details}");
          //   },
          //   onTertiaryTapUp: (TapUpDetails details) {
          //     print("onTertiaryTapUp detail = ${details}");
          //   },
          //   onTertiaryTapCancel: () {
          //     print("onTertiaryTapCancel");
          //   },
          //   onDoubleTapDown: (TapDownDetails details) {
          //     print("onDoubleTapDown detail = ${details}");
          //   },
          //   onDoubleTap: () {
          //     print("onDoubleTap");
          //   },
          //   onDoubleTapCancel: () {
          //     print("onDoubleTapCancel");
          //   },
          //   onLongPressDown: (LongPressDownDetails details) {
          //     print("onLongPressDown detail = ${details}");
          //   },
          //   onLongPressCancel: () {
          //     print("onLongPressCancel");
          //   },
          //   onLongPress: () {
          //     print("onLongPress");
          //   },
          //   // onLongf
          //   onLongPressUp: () {
          //     print("onLongPressUp");
          //   },
          //   onLongPressEnd: (LongPressEndDetails details) {
          //     print("onLongPressEnd detail = ${details}");
          //   },
          //   onSecondaryLongPressDown: (LongPressDownDetails details) {
          //     print("onSecondaryLongPressDown detail = ${details}");
          //   },
          //   onSecondaryLongPressCancel: () {
          //     print("onSecondaryLongPressCancel");
          //   },
          //   onSecondaryLongPress: () {
          //     print("onSecondaryLongPress");
          //   },
          //   onSecondaryLongPressStart: (LongPressStartDetails details) {
          //     print("onSecondaryLongPressStart detail = ${details}");
          //   },
          //   onSecondaryLongPressMoveUpdate:
          //       (LongPressMoveUpdateDetails details) {
          //     print("onSecondaryLongPressMoveUpdate detail = ${details}");
          //   },
          //   onSecondaryLongPressUp: () {
          //     print("onSecondaryLongPressUp");
          //   },
          //   onSecondaryLongPressEnd: (LongPressEndDetails details) {
          //     print("onSecondaryLongPressEnd detail = ${details}");
          //   },
          //   onTertiaryLongPressDown: (LongPressDownDetails details) {
          //     print("onTertiaryLongPressDown detail = ${details}");
          //   },
          //   onTertiaryLongPressCancel: () {
          //     print("onTertiaryLongPressCancel");
          //   },
          //   onTertiaryLongPress: () {
          //     print("onTertiaryLongPress}");
          //   },
          //   onTertiaryLongPressStart: (LongPressStartDetails details) {
          //     print("onTertiaryLongPressStart detail = ${details}");
          //   },
          //   onTertiaryLongPressMoveUpdate:
          //       (LongPressMoveUpdateDetails details) {
          //     print("onTertiaryLongPressMoveUpdate detail = ${details}");
          //   },
          //   onTertiaryLongPressUp: () {
          //     print("onTertiaryLongPressUp");
          //   },
          //   onTertiaryLongPressEnd: (LongPressEndDetails details) {
          //     print("onTertiaryLongPressEnd detail = ${details}");
          //   },
          //
          //   //
          //   // onVerticalDragDown: (DragDownDetails details) { print("onVerticalDragDown detail = ${details}"); },
          //   // onVerticalDragStart: (DragStartDetails details) { print("onVerticalDragStart detail = ${details}"); },
          //   // onVerticalDragUpdate: (DragUpdateDetails details) { print("onVerticalDragUpdate detail = ${details}"); },
          //   // onVerticalDragEnd: (DragEndDetails details) { print("onVerticalDragEnd detail = ${details}"); },
          //   // onVerticalDragCancel: () { print("onVerticalDragCancel"); },
          //
          //   // Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer,
          //   // and a $recognizer gesture recognizer will result in the $recognizer gesture recognizer being ignored,
          //   // since the other two will catch all drags.
          //
          //   onHorizontalDragDown: (DragDownDetails details) {
          //     print("onHorizontalDragDown detail = ${details}");
          //     details;
          //   },
          //   onHorizontalDragStart: (DragStartDetails details) {
          //     print("onHorizontalDragStart detail = ${details}");
          //     isLeftDriving = false;
          //     isRightDriving = false;
          //     {
          //       RenderBox? renderBox = leftDriverKey.currentContext?.findRenderObject() as RenderBox?;
          //       if (renderBox != null) {
          //         Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
          //         Size widgetSize =  renderBox.size;
          //         var widgetRect = Rect.fromLTWH(widgetPosition.dx, 0, widgetSize.width, widgetSize.height);
          //         if (widgetRect.contains(details.localPosition)) {
          //           isLeftDriving = true;
          //         }
          //         // else {
          //         //   print("leftDriverKey widgetPosition = ${widgetPosition}");
          //         //   // print("leftDriverKey widgetSize = ${widgetSize}");
          //         //   print("details.localPosition = ${details.localPosition}");
          //         //   print("没有命中这个widget");
          //         // }
          //       }
          //     }
          //
          //     if (isLeftDriving == false) {
          //       RenderBox? renderBox = rightDriverKey.currentContext?.findRenderObject() as RenderBox?;
          //       if (renderBox != null) {
          //         Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
          //         Size widgetSize =  renderBox.size;
          //         var widgetRect = Rect.fromLTWH(widgetPosition.dx, 0, widgetSize.width, widgetSize.height);
          //         if (widgetRect.contains(details.localPosition)) {
          //           isRightDriving = true;
          //         }
          //       }
          //     }
          //   },
          //   onHorizontalDragUpdate: (DragUpdateDetails details) {
          //     print("onHorizontalDragUpdate detail = ${details}");
          //     setState(() {
          //       _left += details.delta.dx;
          //     });
          //   },
          //   onHorizontalDragEnd: (DragEndDetails details) {
          //     print("onHorizontalDragEnd detail = ${details}");
          //     details;
          //     finishDriving();
          //   },
          //   onHorizontalDragCancel: () {
          //     print("onHorizontalDragCancel");
          //     finishDriving();
          //   },
          //
          //
          //   onForcePressStart: (ForcePressDetails details) {
          //     print("onForcePressStart detail = ${details}");
          //   },
          //   onForcePressPeak: (ForcePressDetails details) {
          //     print("onForcePressPeak detail = ${details}");
          //   },
          //   onForcePressUpdate: (ForcePressDetails details) {
          //     print("onForcePressUpdate detail = ${details}");
          //   },
          //   onForcePressEnd: (ForcePressDetails details) {
          //     print("onForcePressEnd detail = ${details}");
          //   },
          //   // onPanDown: (DragDownDetails details) {
          //   //   print("onPanDown detail = ${details}");
          //   // },
          //   // onPanStart: (DragStartDetails details) {
          //   //   print("onPanStart detail = ${details}");
          //   //
          //   // },
          //   // onPanUpdate: (DragUpdateDetails details) {
          //   //   print("onPanUpdate detail = ${details}");
          //   //   //FIXME:
          //   //   setState(() {
          //   //     // _top += details.delta.dy;
          //   //     _left += details.delta.dx;
          //   //   });
          //   // },
          //   // onPanEnd: (DragEndDetails details) {
          //   //   print("onPanEnd detail = ${details}");
          //   // },
          //   // onPanCancel: () {
          //   //   print("onPanCancel");
          //   // },
          //   // scale is a supersetr of pan
          //   // onScaleStart: (ScaleStartDetails details) { print("onScaleStart detail = ${details}"); },
          //   // onScaleUpdate: (ScaleUpdateDetails details) { print("onScaleUpdate detail = ${details}"); },
          //   // onScaleEnd: (ScaleEndDetails details) { print("onScaleEnd detail = ${details}"); },
          //   child: Container(
          //     height: 100,
          //     width: double.infinity,
          //     color: Colors.amber,
          //     child: Stack(
          //       children: [
          //         Transform.translate(
          //           offset: Offset(_left, _top),
          //           child: Container(
          //             key: leftDriverKey,
          //             width: 30,
          //             height: 30,
          //             color: Colors.blue,
          //           ),
          //         ),
          //
          //         Transform.translate(
          //           offset: Offset(_left, _top + 30),
          //           child: Container(
          //             key: rightDriverKey,
          //             width: 30,
          //             height: 30,
          //             color: Colors.red,
          //           ),
          //         )
          //         // Positioned(
          //         //     left: viewPosition.dx,
          //         //     child: Container(
          //         //       width: 30,
          //         //       height: 30,
          //         //       color: Colors.green,
          //         //     ))
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}

extension _TemplateRouteStateNetWork on _GestureWidgetState {}

extension _TemplateRouteStatePrivate on _GestureWidgetState {}
