// 自定义路由配置
import 'package:fdemo/route/JZPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function(String url, Map<String, dynamic> params);

class JZRouteManager {
  /// 私有的初始化方法
  JZRouteManager._() {}

  static final JZRouteManager instance = JZRouteManager._();

  /// 配置给 MaterialApp的navigatorKey
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 路由注册
  final Map<String, PageBuilder> _pageBuilders = {};
  void registerRoutes(Map<String, PageBuilder> routes) {
    _pageBuilders.addAll(routes);
  }
}

extension JZRouteManagerPublic on JZRouteManager {
  /// 跳转接口
  Future<dynamic> showRoute(String url, Map<String, dynamic> params) {
    NavigatorState? state = JZRouteManager.instance.navigatorKey.currentState;

    // 状态检查
    if (null == state) return Future.value(null);

    /// push结果
    return state.push(JZPageRoute(url, params, (BuildContext context) {
      /// WidgetBuilder的设置
      /// url匹配
      final result = _pageBuilders[url];
      if (result != null) {
        return result(url, params);
      } else {
        /// 请更新APP以支持此路由
        return Container();
      }
    }));
  }
}
