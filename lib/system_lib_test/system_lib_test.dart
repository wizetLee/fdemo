import 'dart:convert';

import 'package:flutter/material.dart';


class SystemLibTestRoute extends StatefulWidget {
  const SystemLibTestRoute({Key? key}) : super(key: key);

  @override
  State<SystemLibTestRoute> createState() => _SystemLibTestRouteState();
}

class _SystemLibTestRouteState extends State<SystemLibTestRoute> {
  @override
  Widget build(BuildContext context) {
    // //1、 慎用subList
    // List<int> list = [1, 2, 3, 4, 5];
    // var target = list.sublist(1, 10);

    Map<String, dynamic> json = {
    "stock_list": ["SZ301002","SZ000591","SH603109","SH688345","SZ300582","SZ000931","SZ300988","SZ002931","SH688616","SZ001696"]};
    var stockList = json['stock_list'].cast<String>();
    print("object = ${stockList}");
    convertTest();

    return Container(color: Colors.orange,);
  }


  convertTest() {

    var map = {
      'name' : 'Justin',
      'age'  : 40,
      'childs' : [
        {
          'name' : 'hamimi',
          'age'  : 3
        }
      ]
    };

    var json = jsonEncode(map);
    print(json);

    var model = TestConvertModel();
    model.name = "xxxx";
    model.age = 101;
    var result = jsonEncode(model);
    print(result);
  }

}

class TestConvertModel {
  String name = "";
  String? name2;
  int age = 0;
  int? age2;
  TestConvertModel? predecessor;
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['age'] = age;
    return map;
  }
}