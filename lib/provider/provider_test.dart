import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider 的使用
class ProviderTestRoute extends StatefulWidget {
  const ProviderTestRoute({Key? key}) : super(key: key);

  @override
  State<ProviderTestRoute> createState() => _ProviderTestRouteState();
}

class _ProviderTestRouteState extends State<ProviderTestRoute> {
  // var _inner = Counter(0);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Provider Demo')),
    //   body: ChangeNotifierProvider(
    //     lazy: true,
    //     create: (BuildContext context) => NotifierCounter(),
    //     child: const ProvidersDemo(),
    //   ),
    // );

    ValueNotifier<String> n = ValueNotifier("cxx");
    n.value = "c";
    final widget = ValueListenableBuilder(
        valueListenable: n,
        builder: (context, value, child) {
          print("value change = ${value}");
          return Container();
        });

    // 监听的对象啊
    return Container(
      color: Colors.white,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => Counter(0),
        child: TmpStateful(),
        lazy: true,
      ),
    );
  }
}

class TmpStateful extends StatefulWidget {
  const TmpStateful({Key? key}) : super(key: key);

  @override
  State<TmpStateful> createState() => _TmpStatefulState();
}

class _TmpStatefulState extends State<TmpStateful> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 50,
            child: Consumer(
              builder: (BuildContext context, Counter counter, child) {
                return Text('${Provider.of<Counter>(context).count}',
                    style: const TextStyle(fontSize: 45));
              },
            )),
        GestureDetector(
          onTap: () {
            print("xxx");
            context.read<Counter>().add();
          },
          child: Container(
            height: 44,
            color: Colors.orange,
          ),
        )
      ],
    );
  }
}

class Counter with ChangeNotifier {
  int _count;
  Counter(this._count);

  add() {
    _count = _count + 1;
    this.notifyListeners(); // 通知修改
  }

  minus() {
    _count = _count - 1;
    this.notifyListeners();
  }

  get count {
    return _count;
  }
}

class ProvidersDemo extends StatelessWidget {
  const ProvidersDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Counter',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        Consumer(
          builder: (BuildContext context, NotifierCounter counter, child) {
            return Text('${counter.count}',
                style: const TextStyle(fontSize: 45));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () => context.read<NotifierCounter>().increment(),
                label: const Text('increment'),
                icon: const Icon(Icons.add)),
            TextButton.icon(
                onPressed: () => context.read<NotifierCounter>().decrement(),
                label: const Text('decrement'),
                icon: const Icon(Icons.remove))
          ],
        )
      ]),
    );
  }
}

class NotifierCounter with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    _notification();
  }

  void decrement() {
    count--;
    _notification();
  }

  void _notification() {
    notifyListeners();
  }
}
