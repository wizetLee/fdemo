import 'package:flutter/material.dart';

/// 设置
class JZPageRouteSettings extends RouteSettings {
  final Map<String, dynamic> params;

  const JZPageRouteSettings(String name, this.params)
      : super(name: name, arguments: params);
}
