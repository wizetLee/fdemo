import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';


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

    // Map<String, dynamic> json = {
    // "stock_list": ["SZ301002","SZ000591","SH603109","SH688345","SZ300582","SZ000931","SZ300988","SZ002931","SH688616","SZ001696"]};
    // var stockList = json['stock_list'].cast<String>();
    // print("object = ${stockList}");
    // convertTest();
    //
    // var c = "IX9074326";
    // var c1 = "IX907";
    //
    // if (c.contains(c1)) {
    //   print("gou");
    // } else {
    //   print("x");
    // }
    //
    //
    var p = Platform();
    print("Platform.environment = ${Platform.environment}");
    print("Platform.operatingSystem = ${Platform.operatingSystem}");
    print("Platform.operatingSystemVersion = ${Platform.operatingSystemVersion}");
    print("Platform.version = ${Platform.version}");
    print("Platform.packageConfig = ${Platform.packageConfig}");
    print("Platform.executableArguments = ${Platform.executableArguments}");
    print("Platform.script = ${Platform.script}");
    print("Platform.resolvedExecutable = ${Platform.resolvedExecutable}");
    // print("Platform.executable = ${Platform.executable}");
    print("Platform.environment = ${Platform.environment}");
    print("Platform.localHostname = ${Platform.localHostname}");
    print("Platform.localeName = ${Platform.localeName}");
    print("Platform.pathSeparator = ${Platform.pathSeparator}");
    print("Platform.numberOfProcessors = ${Platform.numberOfProcessors}");

    var curIndex = 2;
    List<int> rankRowDataList = [1, 2, 3, 4,5, 6, 7, 8, 9];
    List<int>  targetRowDataList = [];
    if (rankRowDataList.length <= 3) {
      targetRowDataList = rankRowDataList;
    } else {
      if (curIndex == 1 || curIndex == 4 || curIndex == 7) {
        targetRowDataList = rankRowDataList.getRange(0, 3).toList();
      } else if (curIndex == 2 || curIndex == 5 || curIndex == 8) {
        if (targetRowDataList.length > 5) {
          targetRowDataList = rankRowDataList.getRange(3, 6).toList();
        } else {
          targetRowDataList = rankRowDataList.getRange((rankRowDataList.length - 3), rankRowDataList.length).toList();
        }
      } else if (curIndex == 3 || curIndex == 6 || curIndex == 9) {
        if (targetRowDataList.length > 8) {
          targetRowDataList = rankRowDataList.sublist(6, 9);
        } else {
          targetRowDataList = rankRowDataList.getRange((rankRowDataList.length - 3), rankRowDataList.length).toList();
        }
      }
    }

    print("targetRowDataList = ${targetRowDataList}");

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