import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class JZSegmentItem extends StatelessWidget {
  static Color selectedBGColor =
      const Color(0xFFFFF2F4); // const Color(0xFD263F).withOpacity(0.06);
  static Color selectedTextColor = const Color(0xFFFD263F);
  static Color normalBGColor = const Color(0xFFF7F7F7);
  static Color normalTextColor = const Color(0xFF999999);

  final double spacing;
  final bool isSelected;
  final String text;

  const JZSegmentItem(
      {required this.text,
      required this.isSelected,
      this.spacing = 8,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSelected = this.isSelected;
    var bgColor = isSelected
        ? JZSegmentItem.selectedBGColor
        : JZSegmentItem.normalBGColor;
    var textColor = isSelected
        ? JZSegmentItem.selectedTextColor
        : JZSegmentItem.normalTextColor;
    return Container(
      padding: EdgeInsets.fromLTRB(spacing / 2, 0, spacing / 2, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            // border: Border.all(
            //   width: 0, color: Colors.transparent),
            color: bgColor),
        height: 32,
        padding: const EdgeInsets.fromLTRB(19, 6, 19, 6),
        child: Text(
          this.text,
          style: TextStyle(
              decoration: TextDecoration.none, fontSize: 14, color: textColor),
        ),
      ),
    );
  }
}

//// 默认高度为50
class JZSegmentView extends StatefulWidget {
  final List<String> tabs;
  //final List<Widget> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTap;

  final double height;
  const JZSegmentView(
      {required this.tabs,
      this.initialIndex = 0,
      this.height = 50,
      this.onTap = null,
      Key? key})
      : super(key: key);

  @override
  State<JZSegmentView> createState() => _JZSegmentViewState();
}

class _JZSegmentViewState extends State<JZSegmentView> {
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
        child: JZSegmentItem(
          isSelected: i == index,
          text: tab,
          spacing: spacing,
        ),
        onTap: () {
          // 点击事件, 切换到对应的index
          this.index = i;

          // 通知回调
          widget.onTap?.call(index);

          // 刷新UI（或者动画切换）
          if (this.mounted) this.setState(() {});
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

  @override
  void didUpdateWidget(covariant JZSegmentView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 控制器检查
  }

  _test() {
    TabBar(tabs: []);
  }

  // @override
  // bool updateShouldNotify(_JZSegmentViewState old) {
  //   return false;
  //   // return enabled != old.enabled || controller != old.controller;
  // }
}

// class JZSegmentViewController extends ChangeNotifier {
//   final int length;
//   JZSegmentViewController({int initialIndex = 0, required this.length})
//       // JZSegmentViewController({ int initialIndex = 0, required this.length, required TickerProvider vsync})
//       : _index = initialIndex,
//         _previousIndex = initialIndex;
//
//   int _previousIndex;
//   int _index;
//
//   int _indexIsChangingCount = 0;
//
//   void _changeIndex(int value, {Duration? duration, Curve? curve}) {
//     assert(value != null);
//     assert(value >= 0 && (value < length || length == 0));
//     assert(duration != null || curve == null);
//     assert(_indexIsChangingCount >= 0);
//     if (value == _index || length < 2) return;
//     _previousIndex = _index;
//     _index = value;
//
//     // if (duration != null && duration > Duration.zero) {
//     //   _indexIsChangingCount += 1;
//     //   notifyListeners(); // Because the value of indexIsChanging may have changed.
//     //   _animationController!
//     //     .animateTo(_index.toDouble(), duration: duration, curve: curve!)
//     //     .whenCompleteOrCancel(() {
//     //       if (_animationController != null) { // don't notify if we've been disposed
//     //         _indexIsChangingCount -= 1;
//     //         notifyListeners();
//     //       }
//     //     });
//     // } else {
//     _indexIsChangingCount += 1;
//     // _animationController!.value = _index.toDouble();
//     _indexIsChangingCount -= 1;
//     notifyListeners();
//     // }
//   }
// }
