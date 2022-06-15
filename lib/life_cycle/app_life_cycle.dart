import 'package:fdemo/route/JZPageRoute.dart';
import 'package:fdemo/route/JZRouteManager.dart';
import 'package:flutter/material.dart';

/// 生命周期检查
class AppLifecycle extends StatefulWidget {

  // AppLifecycle({required Key key}) : super(key: key);

  @override
  _AppLifecycleState createState() {
    print(' sub createState');
    return _AppLifecycleState();
  }
}

class _AppLifecycleState extends State<AppLifecycle>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(' sub initState');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(' didChangeAppLifecycleState');
    if (state == AppLifecycleState.resumed) {
      print(' resumed：');
    } else if (state == AppLifecycleState.inactive) {
      print(' inactive');
    } else if (state == AppLifecycleState.paused) {
      print(' paused');
    } else if (state == AppLifecycleState.detached) {
      print(' detached');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(' sub build');
     return Scaffold(
       // appBar: ,
         body: GestureDetector(
      onTap: () {
        JZRouteManager.instance.showRoute("AppLifecycle2", {});
      },
      child: Container(
        color: Colors.orange,
        child: Center(child: Text('life_Cycle1'),),
    ),));
  }
}