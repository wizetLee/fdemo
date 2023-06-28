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
      body: _scaffoldBody(),
    );
  }
}

extension _TemplateRouteStateWidget on _GestureWidgetState {
  PreferredSizeWidget? _appBar() {
    return null;
  }

  Widget _scaffoldBody() {
    return _body();
  }

  Widget _body() {
    return Container(
      child: Center(
        child: Listener(
            onPointerDown: (PointerDownEvent event) { print("onPointerDown = ${event}"); },
            onPointerMove: (PointerMoveEvent event) {
              print("onPointerMove = ${event}");
              },
            onPointerUp: (PointerUpEvent event) { print("onPointerUp = ${event}"); },
            onPointerHover: (PointerHoverEvent event) { print("onPointerHover = ${event}"); },
            onPointerCancel: (PointerCancelEvent event) { print("onPointerCancel = ${event}"); },
            onPointerPanZoomStart: (PointerPanZoomStartEvent event) { print("onPointerPanZoomStart = ${event}"); },
            onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent event) { print("onPointerPanZoomUpdate = ${event}"); },
            onPointerPanZoomEnd: (PointerPanZoomEndEvent event) { print("onPointerPanZoomEnd = ${event}"); },
            onPointerSignal: (PointerSignalEvent event) {
              print("onPointerSignal = ${event}");
              },
          child: GestureDetector(
            onTapDown: (TapDownDetails details) { print("onTapDown detail = ${details}"); },
            onTapUp: (TapUpDetails details) { print("onTapUp detail = ${details}"); },
            onTap: () { print("onTap"); },
            onTapCancel: () { print("onTapCancel"); },
            onSecondaryTap: () { print("onSecondaryTap"); },
            onSecondaryTapDown: (TapDownDetails details) { print("onSecondaryTapDown detail = ${details}"); },
            onSecondaryTapUp: (TapUpDetails details) { print("onSecondaryTapUp detail = ${details}"); },
            onSecondaryTapCancel: () { print("onSecondaryTapCancel"); },
            onTertiaryTapDown: (TapDownDetails details) { print("onTertiaryTapDown detail = ${details}"); },
            onTertiaryTapUp: (TapUpDetails details) { print("onTertiaryTapUp detail = ${details}"); },
            onTertiaryTapCancel: () { print("onTertiaryTapCancel"); },
            onDoubleTapDown: (TapDownDetails details) { print("onDoubleTapDown detail = ${details}"); },
            onDoubleTap: () { print("onDoubleTap"); },
            onDoubleTapCancel: () { print("onDoubleTapCancel"); },
            onLongPressDown: (LongPressDownDetails details) { print("onLongPressDown detail = ${details}"); },
            onLongPressCancel: () { print("onLongPressCancel"); },
            onLongPress: () { print("onLongPress"); },
            onLongPressStart: (LongPressStartDetails details) { print("onLongPressStart detail = ${details}"); },
            onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) { print("onLongPressMoveUpdate detail = ${details}"); },
            onLongPressUp: () { print("onLongPressUp"); },
            onLongPressEnd: (LongPressEndDetails details) { print("onLongPressEnd detail = ${details}"); },
            onSecondaryLongPressDown: (LongPressDownDetails details) { print("onSecondaryLongPressDown detail = ${details}"); },
            onSecondaryLongPressCancel: () { print("onSecondaryLongPressCancel"); },
            onSecondaryLongPress: () { print("onSecondaryLongPress"); },
            onSecondaryLongPressStart: (LongPressStartDetails details) { print("onSecondaryLongPressStart detail = ${details}"); },
            onSecondaryLongPressMoveUpdate: (LongPressMoveUpdateDetails details) { print("onSecondaryLongPressMoveUpdate detail = ${details}"); },
            onSecondaryLongPressUp: () { print("onSecondaryLongPressUp"); },
            onSecondaryLongPressEnd: (LongPressEndDetails details) { print("onSecondaryLongPressEnd detail = ${details}"); },
            onTertiaryLongPressDown: (LongPressDownDetails details) { print("onTertiaryLongPressDown detail = ${details}"); },
            onTertiaryLongPressCancel: () { print("onTertiaryLongPressCancel"); },
            onTertiaryLongPress: () { print("onTertiaryLongPress}"); },
            onTertiaryLongPressStart: (LongPressStartDetails details) { print("onTertiaryLongPressStart detail = ${details}"); },
            onTertiaryLongPressMoveUpdate: (LongPressMoveUpdateDetails details) { print("onTertiaryLongPressMoveUpdate detail = ${details}"); },
            onTertiaryLongPressUp: () { print("onTertiaryLongPressUp"); },
            onTertiaryLongPressEnd: (LongPressEndDetails details) { print("onTertiaryLongPressEnd detail = ${details}"); },

            //
            // onVerticalDragDown: (DragDownDetails details) { print("onVerticalDragDown detail = ${details}"); },
            // onVerticalDragStart: (DragStartDetails details) { print("onVerticalDragStart detail = ${details}"); },
            // onVerticalDragUpdate: (DragUpdateDetails details) { print("onVerticalDragUpdate detail = ${details}"); },
            // onVerticalDragEnd: (DragEndDetails details) { print("onVerticalDragEnd detail = ${details}"); },
            // onVerticalDragCancel: () { print("onVerticalDragCancel"); },

            // Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer,
            // and a $recognizer gesture recognizer will result in the $recognizer gesture recognizer being ignored,
            // since the other two will catch all drags.
            onHorizontalDragDown: (DragDownDetails details) { print("onHorizontalDragDown detail = ${details}"); },
            onHorizontalDragStart: (DragStartDetails details) { print("onHorizontalDragStart detail = ${details}"); },
            onHorizontalDragUpdate: (DragUpdateDetails details) { print("onHorizontalDragUpdate detail = ${details}"); },
            onHorizontalDragEnd: (DragEndDetails details) { print("onHorizontalDragEnd detail = ${details}"); },
            onHorizontalDragCancel: () { print("onHorizontalDragCancel"); },

            onForcePressStart: (ForcePressDetails details) { print("onForcePressStart detail = ${details}"); },
            onForcePressPeak: (ForcePressDetails details) { print("onForcePressPeak detail = ${details}"); },
            onForcePressUpdate: (ForcePressDetails details) { print("onForcePressUpdate detail = ${details}"); },
            onForcePressEnd: (ForcePressDetails details) { print("onForcePressEnd detail = ${details}"); },
            onPanDown: (DragDownDetails details) { print("onPanDown detail = ${details}"); },
            onPanStart: (DragStartDetails details) { print("onPanStart detail = ${details}"); },
            onPanUpdate: (DragUpdateDetails details) { print("onPanUpdate detail = ${details}"); },
            onPanEnd: (DragEndDetails details) { print("onPanEnd detail = ${details}"); },
            onPanCancel: () {
              print("onPanCancel");
              },
            // scale is a supersetr of pan
            // onScaleStart: (ScaleStartDetails details) { print("onScaleStart detail = ${details}"); },
            // onScaleUpdate: (ScaleUpdateDetails details) { print("onScaleUpdate detail = ${details}"); },
            // onScaleEnd: (ScaleEndDetails details) { print("onScaleEnd detail = ${details}"); },
            child: Container(
              height: 100,
              color: Colors.amber,
              child: Stack(
                children: [
                Positioned(
                    left: 0,
                    child: Container(width: 30, height: 30, color: Colors.green,))
              ],),
            ),
          ),
        ),
      ),
    );
  }
}

extension _TemplateRouteStateNetWork on _GestureWidgetState {}

extension _TemplateRouteStatePrivate on _GestureWidgetState {}
