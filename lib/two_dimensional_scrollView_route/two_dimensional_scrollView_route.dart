/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/11/30 14:35 
* @Description :
*/

import 'package:fdemo/two_dimensional_scrollView_route/two_dimensional_scrollables.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TwoDimensionalScrollViewRoute extends StatefulWidget {
  const TwoDimensionalScrollViewRoute({super.key});

  @override
  State<TwoDimensionalScrollViewRoute> createState() =>
      _TwoDimensionalScrollViewRouteState();
}

class _TwoDimensionalScrollViewRouteState
    extends State<TwoDimensionalScrollViewRoute> {
  late final ScrollController _verticalController = ScrollController();
  int _rowCount = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Example'),
      ),
      body: TableView.builder(
        cacheExtent: 0,
        pinnedColumnCount: 1,
        pinnedRowCount: 1,
        columnCount: 300,
        rowCount: _rowCount,
        columnBuilder: _buildColumnSpan,
        rowBuilder: _buildRowSpan,
        cellBuilder: _buildCell,
      ),
      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: () {
            if (_verticalController.hasClients) {
              _verticalController.jumpTo(0);
            }
          },
          child: const Text('Jump to Top'),
        ),
        TextButton(
          onPressed: () {
            if (_verticalController.hasClients) {
              _verticalController
                  .jumpTo(_verticalController.position.maxScrollExtent);
            }
          },
          child: const Text('Jump to Bottom'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _rowCount += 10;
            });
          },
          child: const Text('Add 10 Rows'),
        ),
      ],
    );
  }

  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
    return Center(
      child: Text('Tile c: ${vicinity.column}, r: ${vicinity.row}'),
    );
  }

  TableSpan _buildColumnSpan(int index) {
    TableSpanDecoration? decoration;
    // = TableSpanDecoration(
    //   border: TableSpanBorder(
    //     trailing: BorderSide(),
    //   ),
    // );
    return TableSpan(
      foregroundDecoration: decoration,
      extent: const FixedTableSpanExtent(100),
      onEnter: (_) => print('Entered column $index'),
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) =>
              t.onTap = () => print('Tap column $index'),
        ),
      },
    );
  }

  TableSpan _buildRowSpan(int index) {
    final TableSpanDecoration decoration = TableSpanDecoration(
      color: null,
      border: const TableSpanBorder(
        trailing: BorderSide(width: 0.5),
      ),
    );

    FixedTableSpanExtent extent = FixedTableSpanExtent(50);
    return TableSpan(
      backgroundDecoration: decoration,
      extent: extent,
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) => t.onTap = () => print('Tap row $index'),
        ),
      },
    );
  }
}
