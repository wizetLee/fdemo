import 'dart:async';
import 'dart:math' as math;

import 'package:fdemo/test/sliver_widget.dart';
import 'package:fdemo/test/table_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TestRoute extends StatefulWidget {
  const TestRoute({Key? key}) : super(key: key);

  @override
  State<TestRoute> createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute>
    with
        // SingleTickerProviderStateMixin
        TickerProviderStateMixin {
  // 一对多的模式

  var streamController = StreamController<String>.broadcast(onListen: () {
    print("xxxx");
  });

  @override
  void initState() {
    super.initState();

    streamController.stream.listen((event) {
      print("xxxxx = event = ${event}");
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// Sink

    TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () {}
          ..onTapDown = (detail) {});

    // 测试一下这个？？？？？
    Autocomplete<String>(
      displayStringForOption: (ooo) {
        return "";
      },
      optionsBuilder: (s) async {
        return [];
      },
      onSelected: (str) {},
    );

    // return Scaffold(
    //   body: DraggableExample(),
    //   // body: SliverAppBarExample(),
    // );
    Color _color = Colors.white;
    String _label = 'Unfocused';

    return Scaffold(
      appBar: AppBar(
        title: Text("xxx"),
        actions: [
          dropdownButtonWidget(),
          popupBtn(),
        ],
      ),
      body: Container(
        color: Colors.pink,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return
//                       ConstrainedBox(
// //没有下面的最小高度的话，当只有一行文字的时候.9图片无法显示
//                         constraints: BoxConstraints(minHeight: 50),
//                         child:
                       Column(children: [
                         Container(
                           // width: 267,
                           width: 267,
                           height: 120,
                           decoration: BoxDecoration(
                             image: DecorationImage(
                               scale: 3,
                               fit: BoxFit.scaleDown,
                               centerSlice: Rect.fromLTRB(2, 2, 8, 8),
                               image: AssetImage(
                                 'assets/image/rise_side_rect.webp',
                               ),
                             ),
                           ),
                         ),
                         Container(
                           // width: 267,
                           width: 300,
                           height: 40,
                           decoration: BoxDecoration(
                             color: Colors.blue,
                             image: DecorationImage(
                               scale: 3,
                               fit: BoxFit.fill,
                               centerSlice: Rect.fromLTRB(2, 2, 38, 38),
                               image: AssetImage(
                                 'assets/image/rise_side_rect.webp',
                               ),
                             ),
                           ),
                         )

                       ],);
                        //     child: ConstrainedBox(
                        //       constraints: BoxConstraints(maxWidth: 200),
                        //       // child:Text(
                        //       // "${messageBeanData.messageContent}",
                        //     )));
                    //   Container(
                    //   height: 80,
                    //   width: 200,
                    //   alignment: Alignment.topLeft,
                    //   child: Image(
                    //     color: Colors.green,
                    //     image: AssetImage('assets/image/rise_side_rect.webp',
                    //       // package: 'fdemo',
                    //     ),
                    //     // JZCommonImages.image(
                    //     //     "limit_up/rise_side_rect.webp",
                    //     //     enableDayNight: false,
                    //     //     package: JZStockImages.package),
                    //     width: 150,
                    //     height: 40,
                    //     // fit: BoxFit.fitHeight,
                    //     // color: JZColor.v4TextMain,
                    //     // centerSlice: Rect.fromLTRB(5, 5, 10, 10),
                    //   ),
                    // );
                  }),
              StreamBuilder(
                  stream: streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!);
                    }
                    return Text(snapshot.data ?? "snapshot.data");
                  }),
              StreamBuilder(
                  stream: streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Text(snapshot.data ?? "snapshot.data");
                  }),
              Builder(builder: (context) {
                return GestureDetector(
                    onTap: () {
                      // 貌似没有区别？
                      streamController.add("xxx");
                      // streamController.sink.add("xx");

                      final RenderBox? overlay = Navigator.of(context)
                          .overlay!
                          .context
                          .findRenderObject() as RenderBox;
                      // _RenderTheatre#529ca
                      // var f_status = Scaffold.of(context);
                      var cFR = context.findRenderObject();

                      // RepaintBoundary

                      // Flutter提供了一个RepaintBoundaryWidget来实现截图的功能，
                      // 用RepaintBoundary包裹需要截取的部分，RenderRepaintBoundary可以将RepaintBoundary包裹的部分截取出来；
                      // 然后通过boundary.toImage()方法转化为ui.Image对象，再使用image.toByteData()将image转化为byteData；
                      // 最后通过File().writeAsBytes()存储为文件对象

                      // RepaintBoundary -
                      // RenderPhysicalModel
                      var f = Scaffold.of(context)?.context.findRenderObject()
                          as RenderBox;

                      // 找父节点中的某个renderObject
                      // Scaffold.of(context)?.context.findAncestorRenderObjectOfType()

                      RepaintBoundary? c = Scaffold.of(context)
                          ?.context
                          .findAncestorWidgetOfExactType();
                      var ccc = Scaffold.of(context)
                          ?.context
                          .findAncestorRenderObjectOfType();
                      if (c != null) {
                        print("xxxx");
                      }
                      // 找到对应的renderObject

                      if (ccc != null) {
                        print("xxx");
                      }

                      // context.findRenderObject() as RepaintBoundary;
                      // var c = RenderRepaintBoundary.of(context);

                      //RepaintBoundary

                      if (f != null) {
                        print("xccc");
                      }
                      if (cFR != null) {
                        print("xccc");
                      }
                      if (overlay != null) {
                        print(overlay);
                      }

                      [1, 2, 3, 4, 5, 6, 7, 8].take(100);
                      var result =
                          [1, 2, 3, 4, 5, 6, 7, 8].map((e) => e).take(100);
                      print("xxx result = $result");

                      // // 时间差测试
                      // var range = List<int>.generate(1000000000, (index) => index);
                      // var d0 = DateTime.now().millisecondsSinceEpoch;
                      // range.map((e) => e).map((e) => e).toList();
                      // var d1 = DateTime.now().millisecondsSinceEpoch;
                      // range.forEach((element) {});
                      // var d2 = DateTime.now().millisecondsSinceEpoch;
                      // print("时间差 ${d1 - d0}    时间差 ${d2 - d1}");
                    },
                    child: Container(
                      color: Colors.green,
                      width: 100,
                      height: 100,
                    ));
              }),
              SizedBox(
                height: 10,
              ),
              Container(
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.topLeft,
                  child:
                      // UnconstrainedBox(
                      //   // child:  Container(color: Colors.orange, width: 1009, height: 1009,),
                      //   ),
                      OverflowBox(
                    maxWidth: 200.0,
                    maxHeight: 200.0,
                    child: GestureDetector(
                        onTap: () {
                          print("xxxxxx");
                        },
                        child: Container(
                          color: Colors.orange,
                          width: double.infinity,
                          height: double.infinity,
                        )),
                  )),
              Container(
                color: Colors.black,
                child: Transform(
                  alignment: Alignment.center,
                  // transform: Matrix4.identity(),
                  transform: Matrix4.skewY(-0.2)..rotateZ(0.2),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: const Color(0xFFE8581C),
                    child: const Text('Apartment for rent!'),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Flow(
                  delegate: TestFlowDelegate(menuAnimation: menuAnimation),
                  children: menuItems
                      .map<Widget>((IconData icon) => flowMenuItem(icon))
                      .toList(),
                ),
              ),

              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith((states) {
                  //FIXME: 怎么没有效果？
                  const Set<MaterialState> interactiveStates = <MaterialState>{
                    MaterialState.pressed,
                    MaterialState.hovered,
                    MaterialState.focused,
                  };
                  if (states.any(interactiveStates.contains)) {
                    return Colors.blue;
                  }
                  var result = interactiveStates.map((e) => e).take(100);

                  return Colors.green;
                }),
                value: true,
                onChanged: (bool? value) {
                  Map<String, String> c = {"1": "2"};
                  c["cc"] = "22";

                  setState(() {});
                },
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return TableWidgetRoute();
                    }));
                  },
                  child: Container(
                    child: Text("Table"),
                  )),

              GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SliverWidgetRoute();
                    }));
                  },
                  child: Container(
                    child: Text("SliverWidgetRoute"),
                  )),
              // 这个组件怎么使用呢？
              Focus(
                onFocusChange: (focused) {
                  // 按tab键，检查结果
                  // _color = focused ? Colors.black26 : Colors.white;
                  // _label = focused ? 'Focused' : 'Unfocused';
                  // setState(() {
                  // });
                },
                child: Container(
                  child: Container(
                    width: 300,
                    height: 50,
                    alignment: Alignment.center,
                    color: _color,
                    child: Text(_label),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget popupBtn() {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> list = [];
        var i = PopupMenuItem<String>(
          child: Text("xxx"),
          onTap: () {},
        );
        list.add(i);
        return list;
      },
    );
  }

  DropdownButton dropdownButtonWidget() {
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValue = list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Container(),
      // icon: const Icon(Icons.arrow_downward),
      elevation: 0,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  late AnimationController menuAnimation = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  IconData lastTapped = Icons.notifications;

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 45.0,
        ),
      ),
    );
  }

  Widget _customScrollView() {
    return CustomScrollView(
      slivers: [],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  TestFlowDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(TestFlowDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

//------------------------------------------------------------------------------------------------------------------------------------------------
class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Sample'),
          notificationPredicate: (ScrollNotification notification) {
            // return notification.depth == 1;
            return true;
          },
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.brightness_5_sharp),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[2]} $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------
class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SliverAppBarExample(),
    );
  }
}

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({super.key});

  @override
  State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 260.0,
              flexibleSpace:
                  // Container(color: Colors.green,
                  // child: Container(
                  //   alignment: Alignment.center,
                  //   child: Text("xx", style: TextStyle(fontSize: 12, color: Colors.white),),)
                  // ),
                  const FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                background: FlutterLogo(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        // The property snap can only be set to true if floating is also true.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
              // ElevatedButton(
              //     onPressed: () {
              //
              //       // FractionallySizedBox
              //     },
              //     child: Text("dragging")),
            ],
          ),
        ),
      ),
    );
  }
}

//-----
class DraggableExample extends StatefulWidget {
  const DraggableExample({Key? key}) : super(key: key);

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
        //初始化占用父容器高度
        initialChildSize: 0.5,
        //占用父组件的最小高度
        minChildSize: 0.25,
        //占用父组件的最大高度
        maxChildSize: 1,
        //是否应扩展以填充其父级中的可用空间默认true 父组件是Center时设置为false,才会实现center布局，但滚动效果是向两边展开
        expand: true,
        //true：触发滚动则滚动到m
        builder: (context, scrollController) {
          return Container(
            color: Colors.blue[100],
            child: ListView.builder(
              controller: scrollController,
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          );
          return Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 10000,
                width: 200,
                color: Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
