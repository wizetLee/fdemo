/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/11/30 14:35 
* @Description :
*/

import 'package:fdemo/two_dimensional_scrollView_route/jz_2d_scroll_view.dart';
import 'package:fdemo/two_dimensional_scrollView_route/table_view/jz_table_span_border.dart';
import 'package:fdemo/two_dimensional_scrollView_route/two_dimensional_scrollables.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
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
  late final ScrollController _hController = ScrollController();
  int _rowCount = 21;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Example'),
      ),
      body: _body(),
      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: () {
            // if (_verticalController.hasClients) {
            //   _verticalController.jumpTo(0);
            // }
          },
          child: const Text('Jump to Top'),
        ),
        TextButton(
          onPressed: () {
            // if (_verticalController.hasClients) {
            //   _verticalController
            //       .jumpTo(_verticalController.position.maxScrollExtent);
            // }
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PrimaryScrollController.maybeOf(context)?.addListener(() {
        print(
            "${PrimaryScrollController.maybeOf(context)?.positions.last.pixels}");
      });
    });
  }

  Widget _body() {
    // return JZ2DScrollView(
    //   rowHeightMap: {0: 32},
    //   columnWidthMap: {0: 50},
    //   borderColor: Colors.greenAccent,
    //   horizontalController: _hController,
    //   // controller: _verticalController,
    //   cellProvider: (BuildContext context, int row, int column) {
    //     return GestureDetector(
    //       onTap: () {
    //         // var primaryScrollController = PrimaryScrollController.maybeOf(context);
    //         // if (primaryScrollController != null) {
    //         //   primaryScrollController.positions.last.jumpTo(100);
    //         // }
    //         _hController.jumpTo(100);
    //       },
    //       child: Container(
    //         alignment: Alignment.center,
    //         color: (column == 0 || row == 0) ? Colors.orange : Colors.white,
    //         child: Text("${row}-${column}"),
    //       ),
    //     );
    //   },
    //   columnCount: 10,
    //   rowCount: 100,
    // );
    return ExtendedNestedScrollView(
      controller: _verticalController,
      pinnedHeaderSliverHeightBuilder: () {
        return 10;
      },
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: _topHeader(),
          ),
        ];
      },
      onlyOneScrollInBody: true,
      body: JZ2DScrollView(
        rowHeightMap: {0: 32},
        columnWidthMap: {0: 50},
        borderColor: Colors.greenAccent,
        horizontalController: _hController,
        controller: _verticalController,
        cellProvider: (BuildContext context, int row, int column) {
          return GestureDetector(
            onTap: () {
              var primaryScrollController = PrimaryScrollController.maybeOf(context);
              if (primaryScrollController != null && primaryScrollController.positions.isNotEmpty) {
                primaryScrollController.positions.last.jumpTo(100);
              }
              _verticalController.jumpTo(_verticalController.positions.last.pixels + 100);
              // _hController.jumpTo(100);
            },
            child: Container(
              alignment: Alignment.center,
              color: (column == 0 || row == 0) ? Colors.orange : Colors.white,
              child: Text("${row}-${column}"),
            ),
          );
        },
        columnCount: 10,
        rowCount: 100,
      ),
    );
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          controller: _verticalController,
          child: Column(
            children: [
              Container(
                color: Colors.orange,
                height: 200,
                child: JZ2DScrollView(
                  borderColor: Colors.greenAccent,
                  controller: _verticalController,
                  cellProvider: (BuildContext context, int row, int column) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        color: (column == 0 || row == 0)
                            ? Colors.orange
                            : Colors.white,
                        child: Text("${row}-${column}"),
                      ),
                    );
                  },
                  columnCount: 10,
                  rowCount: 10,
                ),
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
              Container(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );

    return TableView.builder(
      cacheExtent: 0,
      pinnedColumnCount: 1,
      pinnedRowCount: 1,
      columnCount: 20,
      rowCount: _rowCount,
      columnBuilder: _buildColumnSpan,
      rowBuilder: _buildRowSpan,
      cellBuilder: _buildCell,
    );
  }

  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
    return Center(
      child: Text('Tile c: ${vicinity.column}, r: ${vicinity.row}'),
    );
  }

  TableSpan _buildColumnSpan(int index) {
    TableSpanDecoration? decoration = TableSpanDecoration(
      border: JZStockTableSpanBorder(
        trailing: BorderSide(width: 0.5),
      ),
    );
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
    print("_buildRowSpan = ${index}");
    TableSpanDecoration? decoration = TableSpanDecoration(
      color: Colors.transparent,
      border: JZStockTableSpanBorder(
        trailing: BorderSide(width: 0.5),
        leadingSpace: 15,
        trailingSpace: 15,
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

  Widget _topHeader() {
    return Stack(
      children: [
        Container(
          height: 350,
        )
      ],
    );
  }
}
