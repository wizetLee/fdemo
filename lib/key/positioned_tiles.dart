import 'dart:math';

import 'package:flutter/material.dart';


/*
ListView
  Card
    ListTitle


动画部分
https://segmentfault.com/a/1190000022821675 


*/


/*
ValueKey
Objectkey
Uniquekey
PageStoragekey
GlobalKey
*/

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  // List<Widget> tiles = [
  //   StatelessColorfulTile(),
  //   StatelessColorfulTile(),
  // ];

  // List<Widget> tiles = [
  //   MyStatefulColorfultileWidget(),
  //   MyStatefulColorfultileWidget(),
  // ];

  List<Widget> tiles = [
    MyStatefulColorfultileWidget(
      key: UniqueKey(),
    ),
    MyStatefulColorfultileWidget(
      key: UniqueKey(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {
  Color myColor = ColorUtils.getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: myColor, child: Padding(padding: EdgeInsets.all(70.0)));
  }
}

class ColorUtils {
  ///获取随机颜色
  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }
}

class MyStatefulColorfultileWidget extends StatefulWidget {
  const MyStatefulColorfultileWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulColorfultileWidget> createState() =>
      _MyStatefulColorfultileWidgetState();
}

class _MyStatefulColorfultileWidgetState
    extends State<MyStatefulColorfultileWidget> {
  Color myColor = ColorUtils.getRandomColor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: myColor,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}
