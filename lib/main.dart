import 'package:fdemo/graph/rich_graph_route.dart';
import 'package:flutter/material.dart';

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
      final item = Item(title: "a");
      item.action = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RichGraphRoute(),
          ),
        );
      };
      list.add(item);
    }
    {
      final item = Item(title: "b");
      list.add(item);
    }
    return list;
  }
}

class Item {
  final title;
  Function? action;
  Item({this.title});
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
              child: Text("xxx"),
            ),
            SizedBox(
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