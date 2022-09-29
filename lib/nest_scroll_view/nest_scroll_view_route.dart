import 'package:flutter/material.dart';

class NestScrollViewRoute extends StatefulWidget {
  const NestScrollViewRoute({Key? key}) : super(key: key);

  @override
  State<NestScrollViewRoute> createState() => _NestScrollViewRouteState();
}

class _NestScrollViewRouteState extends State<NestScrollViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child:
      NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        print("headerSliverBuilder closure  --- innerBoxIsScrolled = $innerBoxIsScrolled");

        return [];
      },
      body: Container(color: Colors.yellow,),
      ),
    );
  }
}
