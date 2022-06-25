import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnnotateRoute extends StatefulWidget {
  const AnnotateRoute({Key? key}) : super(key: key);

  @override
  State<AnnotateRoute> createState() => _AnnotateRouteState();
}

class _AnnotateRouteState extends State<AnnotateRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
      ),
    );
  }
}
