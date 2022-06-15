import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'jz_segmented_item.dart';

//// 默认高度为50
class JZSegmentedView extends StatefulWidget {

  /// 当前只适配了默认的样式
  final List<String> tabs;

  //final List<Widget> tabs; // 后期适配

  /// 初始化选中的角标
  final int initialIndex;

  /// bool 选择是否选中效果
  /// index 选中的项的角标
  final bool Function(int index)? onTap;

  final double height;
  const JZSegmentedView(
      {required this.tabs,
      this.initialIndex = 0,
      this.height = 50,
      this.onTap = null,
      Key? key})
      : super(key: key);

  @override
  State<JZSegmentedView> createState() => _JZSegmentedViewState();
}

class _JZSegmentedViewState extends State<JZSegmentedView> {
  /// 当前选中的角标
  int index = 0;

  @override
  void initState() {
    super.initState();
    this.index = this.widget.initialIndex;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var index = this.index;
    final padding = EdgeInsets.fromLTRB(16, 0, 16, 0);
    double spacing = 8;
    List<Widget> items = [];
    for (int i = 0; i < this.widget.tabs.length; i++) {
      final tab = this.widget.tabs[i];
      final item = GestureDetector(
        child: JZSegmentedItem(
          isSelected: i == index,
          text: tab,
          spacing: spacing,
        ),
        onTap: () {
          final result = widget.onTap?.call(i) ?? true;
          if (result) {
            this.index = i;
            if (this.mounted) this.setState(() {});
          }
        },
      );
      items.add(item);
    }
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          padding.left - spacing / 2, 0, padding.right - spacing / 2, 0),
      child: Container(
        height: this.widget.height,
        color: Colors.transparent,
        child: Row(
          children: items,
        ),
      ),
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
    );
  }
}
