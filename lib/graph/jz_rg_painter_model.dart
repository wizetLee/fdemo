/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/9/21 13:41 
* @Description :
*/


import 'package:flutter/material.dart';

/// 绘制模型的单个数据
class JZRGLinesPainterElement {
  /// 原始数据
  dynamic origin;

  /// 数值（呈现数值，而非转化后的数值
  double renderValue;

  JZRGLinesPainterElement({required this.renderValue, required this.origin});
}

enum JZRGEachPainterModelStyle {
  line,

  /// 分红绿色的柱状
  columnar,

  /// 只有正方向的柱
  positiveColumnar,

}

// 坐标系统

/// 单个绘制模型的详细配置
class JZRGEachPainterModel {
  /// 绘制模型
  List<JZRGLinesPainterElement> elements = [];

  Color color = Colors.red;

  double strokeWidth = 1;

  JZRGEachPainterModelStyle style = JZRGEachPainterModelStyle.line;

  // 判断用哪一个坐标系，如果作为独立坐标系，则不填写就行
  AxisDirection? axisDirection = AxisDirection.left;

  bool showGesturePoint = true;

}