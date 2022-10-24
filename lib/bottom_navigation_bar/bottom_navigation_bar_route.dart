import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class BottomNavigationBarRoute extends StatefulWidget {
  const BottomNavigationBarRoute({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarRoute> createState() => _BottomNavigationBarRouteState();
}

class _BottomNavigationBarRouteState extends State<BottomNavigationBarRoute> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(), bottomNavigationBar: _bottomNavigationBar(),);
  }

  _body() {
      return _currBody;
  }

  late var _currBody = Container(color: Colors.orange,);




  Duration animationDuration = Duration(milliseconds: 250);
  late AnimationController idleAnimation = AnimationController(vsync: this);
  late AnimationController onSelectedAnimation = AnimationController(vsync: this, duration: animationDuration);
  late AnimationController onChangedAnimation = AnimationController(vsync: this, duration: animationDuration);

  var selectedIndex = 0;
  var previousIndex;
  _bottomNavigationBar() {

    AnimationController indexController(int index) {
      return selectedIndex == index
          ? onSelectedAnimation
          : previousIndex == index
          ? onChangedAnimation
          : idleAnimation;
    }


    return BottomNavigationBar(
      type:BottomNavigationBarType.fixed,
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
      currentIndex: selectedIndex,
      onTap: (index) {
        this.setState(() {
          if (selectedIndex == index) {
            return;
          }

          { // 动画
            onSelectedAnimation.reset();
            onSelectedAnimation.forward();

            onChangedAnimation.value = 1;
            onChangedAnimation.reverse();
          }
          { // 位置处理
            previousIndex = selectedIndex;
            selectedIndex = index;
          }

          if (index == 0) {
            _currBody = Container(color: Colors.orange,);
          } else if (index == 1) {
            _currBody = Container(color: Colors.blue,);
          } else if (index == 2) {
            _currBody = Container(color: Colors.pink,);
          }
        });
        print("xxxxx $index" );
      },
      items: <BottomNavigationBarItem>[
        /*icon和activeIcon分别代表未选中和选中*/
        BottomNavigationBarItem(label: "xxx", icon: Lottie.asset("assets/lottie/home_data.json",
            height: 22,
            controller: indexController(0))),
          // activeIcon: Icon(Icons.home) 正式使用的时候加上activeIcon
        BottomNavigationBarItem(label: '书籍', icon: Lottie.asset("assets/lottie/manager_data.json",
    height: 22,
    controller: indexController(1))),
        BottomNavigationBarItem(label: '我的', icon: Lottie.asset("assets/lottie/optional_data.json",
    height: 22,
    controller: indexController(2))),
      ],
    );
  }
}
