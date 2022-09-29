import 'package:fdemo/animation/animation_route.dart';
import 'package:fdemo/annotate/annotate_route.dart';
import 'package:fdemo/font/font_route.dart';
import 'package:fdemo/graph/rich_graph_demo_route.dart';
import 'package:fdemo/provider/provider_test.dart';
import 'package:fdemo/segment/jz_segmented_view.dart';
import 'package:fdemo/slider/slider_route.dart';
import 'package:fdemo/system_lib_test/system_lib_test.dart';
import 'package:flutter/material.dart';
import 'key/positioned_tiles.dart';
import 'life_cycle/app_life_cycle.dart';
import 'life_cycle/app_life_cycle2.dart';
import 'mobx/mobx_route.dart';
import 'nest_scroll_view/nest_scroll_view_route.dart';
import 'route/JZRouteManager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorKey: JZRouteManager.instance.navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    /// 注册路由处
    Map<String, PageBuilder> map = Map();
    map["b"] = (url, params) {
      return Container(
        color: Colors.redAccent,
      );
    };
    map["c"] = (url, params) {
      return Container(
          color: Colors.white,
          height: 50,
          child: Column(
            children: [
              Container(height: 150),
              JZSegmentedView(
                tabs: ["阿萨姆拼凑", "奥斯蒂", "阿是蛮拼的吗", "现在才在"],
                initialIndex: 2,
                onTap: (index) {
                  if (index == 2) {
                    return false;
                  }
                  return true;
                },
              ),
              Divider(),
            ],
          ));
    };
    map["d"] = (url, params) {
      return Container(
        // child: JZSegmentView(tabs: ["1", "2", "3", "4", "5"]),
        child: FontRoute(),
      );
    };
    map["AppLifecycle"] = (url, params) {
      return AppLifecycle();
    };
    map["AppLifecycle2"] = (url, params) {
      return AppLifecycle2();
    };
    map["PositionedTiles"] = (url, params) {
      return PositionedTiles();
    };
    map["SystemLibTest"] = (url, params) {
      return SystemLibTestRoute();
    };
    map["ProviderTest"] = (url, params) {
      return ProviderTestRoute();
    };
    map["annotate"] = (url, params) {
      return AnnotateRoute();
    };
    map["AnimationRoute"] = (url, params) {
      return AnimationRoute();
    };
    map["MobxRoute"] = (url, params) {
      return MobxRoute();
    };
    map["Slider"] = (url, params) {
      return SliderRoute();
    };
    map["NestScrollViewRoute"] = (url, params) {
      return NestScrollViewRoute();
    };

    JZRouteManager.instance.registerRoutes(map);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = list();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(
            item: l[index],
          );
        },
        itemCount: l.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Item> list() {
    List<Item> list = [];

    {
      final item = Item(title: "ProviderTest");
      item.action = () {
        JZRouteManager.instance.showRoute("ProviderTest", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "系统API测试");
      item.action = () {
        JZRouteManager.instance.showRoute("SystemLibTest", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "传统的跳转Navigator.push：Graph");
      item.action = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RichGraphDemoRoute(),
          ),
        );
      };
      list.add(item);
    }
    {
      final item = Item(title: "红色背景的路由");
      item.action = () {
        JZRouteManager.instance.showRoute("b", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "一个无效的路由： JZSegmentView");
      item.action = () {
        JZRouteManager.instance.showRoute("c", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "文字检查");
      item.action = () {
        JZRouteManager.instance.showRoute("d", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "AppLifecycle");
      item.action = () {
        JZRouteManager.instance.showRoute("AppLifecycle", {});
      };
      list.add(item);
    }

    {
      final item = Item(title: "PositionedTiles");
      item.action = () {
        JZRouteManager.instance.showRoute("PositionedTiles", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "注解");
      item.action = () {
        JZRouteManager.instance.showRoute("annotate", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "AnimationRoute");
      item.action = () {
        JZRouteManager.instance.showRoute("AnimationRoute", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "MobxRoute");
      item.action = () {
        JZRouteManager.instance.showRoute("MobxRoute", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "Slider");
      item.action = () {
        JZRouteManager.instance.showRoute("Slider", {});
      };
      list.add(item);
    }
    {
      final item = Item(title: "NestScrollViewRoute");
      item.action = () {
        JZRouteManager.instance.showRoute("NestScrollViewRoute", {});
      };
      list.add(item);
    }

    return list;
  }
}

class Item {
  final String title;
  Function? action;
  Item({required this.title});
}

class ListItem extends StatelessWidget {
  final Item item;
  const ListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final action = this.item.action;
        if (action != null) {
          action();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 44,
              child: Center(
                child: Text(item.title),
              ),
            ),
            const SizedBox(
              height: 0.5,
              child: Divider(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
