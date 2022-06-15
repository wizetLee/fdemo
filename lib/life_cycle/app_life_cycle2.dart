import 'package:fdemo/route/JZRouteManager.dart';
import 'package:flutter/material.dart';



/// 生命周期检查
class AppLifecycle2 extends StatefulWidget {

  // AppLifecycle({required Key key}) : super(key: key);

  @override
  _AppLifecycle2State createState() {
    print(' life cycle 2 sub createState');
    return _AppLifecycle2State();
  }
}

class _AppLifecycle2State extends State<AppLifecycle2>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(' life cycle 2 sub initState');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(' life cycle 2 didChangeAppLifecycleState');
    if (state == AppLifecycleState.resumed) {
      print(' life cycle 2 resumed：');
    } else if (state == AppLifecycleState.inactive) {
      print(' life cycle 2 inactive');
    } else if (state == AppLifecycleState.paused) {
      print(' life cycle 2 paused');
    } else if (state == AppLifecycleState.detached) {
      print(' life cycle 2 detached');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(' life cycle 2 sub build');
    return Scaffold(body: GestureDetector(
      child: Container(
        color: Colors.greenAccent,
        child: Center(child: Text('life_Cycle2'),),
      ),),);
  }
}