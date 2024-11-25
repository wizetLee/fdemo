/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2024/1/28 14:57 
* @Description :
*/

import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 另外如果需要定位某个widget的位置可以使用CompositedTransformFollower 与 CompositedTransformTarget
/// 可以参考：https://juejin.cn/post/6946416845537116190
///
/// 关于OverlayPortal，这个widget点对点比较好使，面对复杂场景可能会无法处理
///
/// 理论上应用的所有Overlay逻辑应该由此单例负责
///
/// 设计目标：完成经传多赢APP广告弹窗，或者其他具有全屏展示在页面最顶层需求，逻辑的处理
class JZOverlayManager {
  static JZOverlayManager instance = JZOverlayManager._();

  JZOverlayManager._();

  List<OverlayEntry> overlayEntryStack = [];

  void showOverlay(WidgetBuilder builder,
      {Future<bool> Function()? tapEnable,
      BuildContext? context,
      Color? customBackgroundColor}) {
    OverlayEntry? overlay;
    overlay = OverlayEntry(builder: (ctx) {
      return Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: customBackgroundColor ?? Colors.black.withOpacity(0.75),
            //FIXME: 指定为专门的颜色
            child: GestureDetector(
              onTap: () async {
                if (tapEnable != null) {
                  var result = await tapEnable();
                  if (result) {
                    removeOverLay();
                  }
                } else {
                  removeOverLay();
                }
              },
            ),
          )),
          builder(ctx),
        ],
      );
    });
    if (overlay != null) {
      // var ctx = JZRouteManager.instance.navigatorKey.currentContext ?? context;
      var ctx = context;
      if (ctx != null) {
        Overlay.of(ctx)?.insert(overlay);
        overlayEntryStack.add(overlay);
      }
    }
  }

  void removeOverLay({int? count}) {
    if (count != null) {
      if (kDebugMode) {
        assert((count >= 0), "请检查是否输入错误的值");
      }
      if (count > 0) {
        for (int i = 0; i < count; i++) {
          if (overlayEntryStack.isEmpty) {
            break;
          }
          removeOverLay();
        }
      }
    } else {
      if (overlayEntryStack.isNotEmpty) {
        overlayEntryStack.removeLast().remove();
      }
    }
  }
}
