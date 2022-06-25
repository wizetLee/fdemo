import 'package:flutter/widgets.dart';

class Param {
  final String name;
  final int id;
  const Param(this.name, this.id);
}

@Param("test", 1)
class TestModel {}

// class TestGenerator extends GeneratorForAnnotation<Param> {}
