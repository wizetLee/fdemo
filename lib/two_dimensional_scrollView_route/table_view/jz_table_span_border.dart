/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/12/1 08:57 
* @Description :
*/

import 'package:flutter/material.dart';

import 'table_span.dart';

/// 股票专用的样式
class JZStockTableSpanBorder extends TableSpanBorder {
  /// Creates a [JZStockTableSpanBorder].
  JZStockTableSpanBorder({
    super.trailing = BorderSide.none,
    super.leading = BorderSide.none,
    this.trailingSpace = 0.0,
    this.leadingSpace = 0.0,
  });

  /// 仅影响horizontal
  final double trailingSpace;
  final double leadingSpace;

  /// Called to draw the border around a span.
  ///
  /// If the span represents a row, `axisDirection` will be [AxisDirection.left]
  /// or [AxisDirection.right]. For columns, the `axisDirection` will be
  /// [AxisDirection.down] or [AxisDirection.up].
  ///
  /// The provided [TableSpanDecorationPaintDetails] describes the bounds and
  /// orientation of the span that are currently visible inside the viewport of
  /// the table. The extent of the actual span may be larger.
  ///
  /// If a span contains pinned parts, [paint] is invoked separately for the
  /// pinned and unpinned parts. For example: If a row contains a pinned column,
  /// paint is called with the [TableSpanDecorationPaintDetails.rect] for the
  /// cell representing the pinned column and separately with another
  /// [TableSpanDecorationPaintDetails.rect] containing all the other unpinned
  /// cells.
  void paint(TableSpanDecorationPaintDetails details) {
    final AxisDirection axisDirection = details.axisDirection;
    var rect = details.rect;
    switch (axisDirectionToAxis(axisDirection)) {
      case Axis.horizontal:
        //区分
        // trailingSpace
        // leadingSpace
        if (details.isPinned) {
          rect = Rect.fromLTWH(rect.left + leadingSpace, rect.top,
              rect.width - leadingSpace, rect.height);
        } else {
          rect = Rect.fromLTWH(
              rect.left, rect.top, rect.width - trailingSpace, rect.height);
        }
        paintBorder(
          details.canvas,
          rect,
          top: axisDirection == AxisDirection.right ? leading : trailing,
          bottom: axisDirection == AxisDirection.right ? trailing : leading,
        );
        break;
      case Axis.vertical:
        paintBorder(
          details.canvas,
          rect,
          left: axisDirection == AxisDirection.down ? leading : trailing,
          right: axisDirection == AxisDirection.down ? trailing : leading,
        );
        break;
    }
  }
}
