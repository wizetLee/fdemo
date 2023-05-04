import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomNavigationBarController {}

class FundHomeBottomNavigationBar2 extends StatefulWidget {
  final BottomNavigationBarController controller;

  final void Function(int)? onDidSelected;

  const FundHomeBottomNavigationBar2(
      {Key? key, required this.controller, required this.onDidSelected})
      : super(key: key);

  @override
  State<FundHomeBottomNavigationBar2> createState() =>
      _FundHomeBottomNavigationBar2State();
}

class _FundHomeBottomNavigationBar2State
    extends State<FundHomeBottomNavigationBar2> with TickerProviderStateMixin {
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
    double fontSize = 12.0;
    double iconSize = 22.0;

    List<BottomNavigationBarItem> items = [
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
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: fontSize,
      unselectedFontSize: fontSize,
      currentIndex: selectedIndex,
      onTap: (index) {
        tapIn(index);
      },
      items: items,
    );
  }

  AnimationController indexController(int index) {
    return selectedIndex == index
        ? onSelectedAnimation
        : previousIndex == index
            ? onChangedAnimation
            : idleAnimation;
  }

  void tapIn(int index) {
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
    });
  }
}
