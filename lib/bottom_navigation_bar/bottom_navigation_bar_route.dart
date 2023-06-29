import 'package:fdemo/bottom_navigation_bar/fund_home_bottom_navigation_bar2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomNavigationBarRoute extends StatefulWidget {
  const BottomNavigationBarRoute({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarRoute> createState() =>
      _BottomNavigationBarRouteState();
}

class _BottomNavigationBarRouteState extends State<BottomNavigationBarRoute>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  _body() {
    return _currBody;
  }

  late var _currBody = Container(
    color: Colors.orange,
  );

  var controller = BottomNavigationBarController();

  _bottomNavigationBar() {
    return FundHomeBottomNavigationBar2(
      controller: controller,
      onDidSelected: (index) {
        setState(() {
          if (index == 0) {
            _currBody = Container(
              color: Colors.orange,
            );
          } else if (index == 1) {
            _currBody = Container(
              color: Colors.blue,
            );
          } else if (index == 2) {
            _currBody = Container(
              color: Colors.pink,
            );
          }
        });
      },
    );
  }
}
