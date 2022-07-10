

import 'package:flutter/material.dart';

class AnimationRoute extends StatefulWidget {
  const AnimationRoute({Key? key}) : super(key: key);

  @override
  State<AnimationRoute> createState() => _AnimationRouteState();
}

// 多animation时使用：TickerProviderStateMixin
class _AnimationRouteState extends State<AnimationRoute> with TickerProviderStateMixin {

  late Animation<AlignmentGeometry> _animation;
  late var _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));

  @override
  void initState() {
    super.initState();


    _animation = Tween<AlignmentGeometry>(
        begin: Alignment.topLeft, end: Alignment.bottomRight)
        .animate(_animationController);


    // 开始动画
    begin();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }


  void begin() async {
    Future.delayed(Duration(seconds: 1),(){
      _animationController.forward();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.orange,
    child: Container(
      height: 200,
      width: 200,
      color: Colors.blue,
      child: AlignTransition(
        alignment: _animation,
        child: Container(
          height: 30,
          width: 30,
          color: Colors.red,
        ),
      ),
    ),
    ),);
  }
}



class ButtonTransition extends AnimatedWidget {

  ButtonTransition({required super.listenable});

  @override
  Widget build(BuildContext context) {

    return Container();
  }

}
