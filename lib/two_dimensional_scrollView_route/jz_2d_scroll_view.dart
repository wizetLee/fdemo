/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/11/30 17:26 
* @Description :
*/

import 'package:fdemo/two_dimensional_scrollView_route/two_dimensional_scrollables.dart';
import 'package:flutter/material.dart';

/// 数值计算器
class JZ2DScrollViewCalculator {}

/// 2D滑动组件
class JZ2DScrollView extends StatelessWidget {
  /// 配置的cell
  final Function(BuildContext context, int row, int column) cellProvider;

  /// 列数
  final int columnCount;

  /// 行数
  final int rowCount;

  /// 悬停列
  final int pinnedColumnCount;

  /// 悬停行
  final int pinnedRowCount;

  /// 指定某行高
  final Map<int, double> rowHeightMap;

  /// 指定某列宽
  final Map<int, double> columnWidthMap;

  final double baseHeight;

  final double baseWidth;

  final Color? borderColor;

  final ScrollController? controller;

  final ScrollController? horizontalController;

  const JZ2DScrollView({
    super.key,
    required this.cellProvider,
    required this.columnCount,
    required this.rowCount,
    this.pinnedRowCount = 1,
    this.pinnedColumnCount = 1,
    this.rowHeightMap = const {},
    this.columnWidthMap = const {},
    this.baseHeight = 48,
    this.baseWidth = 80,
    this.borderColor,
    this.controller,
    this.horizontalController,
  })  : assert(pinnedRowCount >= 0),
        assert(pinnedColumnCount >= 0),
        assert(columnCount >= 0),
        assert(rowCount >= 0),
        assert(baseHeight >= 0),
        assert(baseWidth >= 0);

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      diagonalDragBehavior: DiagonalDragBehavior.none,
      cacheExtent: 0,
      pinnedColumnCount: pinnedColumnCount,
      pinnedRowCount: pinnedRowCount,
      columnCount: columnCount,
      rowCount: rowCount,
      columnBuilder: _buildColumnSpan,
      rowBuilder: _buildRowSpan,
      cellBuilder: _buildCell,
      horizontalDetails: ScrollableDetails.horizontal(
          physics: ClampingScrollPhysics(), controller: horizontalController),
      verticalDetails: ScrollableDetails.vertical(
          physics: ClampingScrollPhysics(), controller: controller),
    );
  }

  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
    return cellProvider.call(context, vicinity.row, vicinity.column);
  }

  TableSpan _buildColumnSpan(int index) {
    TableSpanDecoration? decoration = (index == (columnCount - 1))
        ? null
        : TableSpanDecoration(
            color: Colors.transparent,
            border: TableSpanBorder(
              trailing:
                  BorderSide(width: 0.5, color: borderColor ?? Colors.black),
            ),
          );

    double width = columnWidthMap[index] ?? baseWidth;
    FixedTableSpanExtent extent = FixedTableSpanExtent(width);
    return TableSpan(
      foregroundDecoration: decoration,
      extent: extent,
      onEnter: (_) => print('Entered column $index'),
    );
  }

  TableSpan _buildRowSpan(int index) {
    TableSpanDecoration? decoration = (index == (rowCount - 1))
        ? null
        : TableSpanDecoration(
            color: Colors.transparent,
            border: TableSpanBorder(
              trailing:
                  BorderSide(width: 0.5, color: borderColor ?? Colors.black),
            ),
          );
    double height = rowHeightMap[index] ?? baseHeight;
    FixedTableSpanExtent extent = FixedTableSpanExtent(height);
    return TableSpan(
      foregroundDecoration: decoration,
      extent: extent,
    );
  }
}
