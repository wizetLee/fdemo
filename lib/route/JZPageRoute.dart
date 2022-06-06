import 'package:fdemo/route/JZPageRouteSetting.dart';
import 'package:flutter/material.dart';

/// 路由，可设置跳转动画
class JZPageRoute<T> extends MaterialPageRoute<T> {
  /// 初始化设置
  JZPageRoute(String name, Map<String, dynamic> params, WidgetBuilder builder)
      : super(builder: builder, settings: JZPageRouteSettings(name, params));
}
