import 'package:flutter/material.dart';


class TableWidgetRoute extends StatefulWidget {

  TableWidgetRoute({Key? key}) : super(key: key) {
    print("TableWidgetRoute 初始化");
  }

  @override
  State<TableWidgetRoute> createState() => _TableWidgetRouteState();
}

class _TableWidgetRouteState extends State<TableWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {

    List<TableRow> list = [

    ];

    List<int>.generate(100, (index) => index).forEach((element) {
      // 一行

      var tableRow = TableRow(
        children: <Widget>[
          //
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: Container(
              color: Colors.green,
              child: Text("第${element}行"),
            ),
          ),

          //FIXME: 右边怎样才能滑动的
          // 应该怎么操作起来
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: Container(
              height: 32,
              width: 32,
              color: Colors.red,
            ),
          ),

          //
          Container(
            height: 64,
            color: Colors.green,
          ),

          //
          Container(
            height: 64,
            color: Colors.blue,
          ),
        ],
      );
      list.add(tableRow);
    });


    return
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
        child:
        SafeArea(
          child: Table(
            border: TableBorder.all(width: 0.5, color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            // 宽度配置
            columnWidths: const <int, TableColumnWidth>{
              // 0: IntrinsicColumnWidth(),
              // 1: IntrinsicColumnWidth(),
              // 2: IntrinsicColumnWidth(),
              // 3: IntrinsicColumnWidth(),
              // 1: FlexColumnWidth(),
              // 2: FixedColumnWidth(64),
            },
            children: list,
          ),
        ),
      // ),
    );
  }
}