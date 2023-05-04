import 'package:flutter/material.dart';

class BottomNavigationBarController {}

class FundHomeBottomNavigationBar extends StatefulWidget {
  final BottomNavigationBarController controller;

  final void Function(int)? onDidSelected;

  const FundHomeBottomNavigationBar(
      {Key? key, required this.controller, required this.onDidSelected})
      : super(key: key);

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar>
    with TickerProviderStateMixin {
  Duration animationDuration = const Duration(milliseconds: 350);

  late AnimationController idleAnimation = AnimationController(vsync: this);

  late AnimationController onSelectedAnimation =
      AnimationController(vsync: this, duration: animationDuration)..value = 1;

  late AnimationController onChangedAnimation =
      AnimationController(vsync: this, duration: animationDuration);

  int selectedIndex = 0;

  int previousIndex = -1;

  @override
  Widget build(BuildContext context) {
    //FIXME: xxxx

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
      currentIndex: selectedIndex,
      onTap: (index) {
        tapIn(index);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "xxx",
          icon: Lottie.asset("assets/lottie/home_data.json",
              height: iconSize, controller: indexController(0)),
        ),

        BottomNavigationBarItem(
          label: '书籍',
          icon: Lottie.asset("assets/lottie/manager_data.json",
              height: iconSize, controller: indexController(1)),
        ),
        BottomNavigationBarItem(
            label: '我的',
            icon: Lottie.asset("assets/lottie/optional_data.json",
                height: iconSize, controller: indexController(2))),
      ],
    );;
  }

  tapIn(int index) {
    setState(() {
      if (selectedIndex == index && previousIndex >= 0) {
        return;
      }

      {
        // 动画
        onSelectedAnimation.reset();
        onSelectedAnimation.forward();

        onChangedAnimation.value = 1;
        onChangedAnimation.reverse();
      }
      {
        // 位置处理
        previousIndex = selectedIndex;
        selectedIndex = index;
      }

      var onDidSelected = widget.onDidSelected;
      if (onDidSelected != null) {
        onDidSelected(index);
      }

      // if (index == 0) {
      //   _currBody = Container(
      //     color: Colors.orange,
      //   );
      // } else if (index == 1) {
      //   _currBody = Container(
      //     color: Colors.blue,
      //   );
      // } else if (index == 2) {
      //   _currBody = Container(
      //     color: Colors.pink,
      //   );
      // }
    });
    print("xxxxx $index");
  }
}
