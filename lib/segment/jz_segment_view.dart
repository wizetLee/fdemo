import 'package:flutter/material.dart';

class JZSegmentView extends StatefulWidget {
  final List<String> tabs;
  final int initialIndex;
  const JZSegmentView({required this.tabs, this.initialIndex = 0, Key? key})
      : super(key: key);

  @override
  State<JZSegmentView> createState() => _JZSegmentViewState();
}

class _JZSegmentViewState extends State<JZSegmentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = this
        .widget
        .tabs
        .map((e) => Container(
              color: Colors.orange.withOpacity(0.75),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 40,
              child: Center(
                  child: Text(
                e,
                style: TextStyle(decoration: TextDecoration.none, fontSize: 18),
              )),
            ))
        .toList();
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
      child: Row(
        children: items,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant JZSegmentView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 控制器检查
  }

  @override
  bool updateShouldNotify(_JZSegmentViewState old) {
    return false;
    // return enabled != old.enabled || controller != old.controller;
  }
}

// class JZSegmentViewController extends ChangeNotifier {
//   final int length;
//   JZSegmentViewController({ int initialIndex = 0, required this.length})
//   // JZSegmentViewController({ int initialIndex = 0, required this.length, required TickerProvider vsync})
//   :_index = initialIndex, _previousIndex = initialIndex;

//   int _previousIndex;
//   int _index;

// int _indexIsChangingCount = 0;

// void _changeIndex(int value, { Duration? duration, Curve? curve }) {
//     assert(value != null);
//     assert(value >= 0 && (value < length || length == 0));
//     assert(duration != null || curve == null);
//     assert(_indexIsChangingCount >= 0);
//     if (value == _index || length < 2)
//       return;
//     _previousIndex = _index;
//     _index = value;

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
//       _indexIsChangingCount += 1;
//       // _animationController!.value = _index.toDouble();
//       _indexIsChangingCount -= 1;
//       notifyListeners();
//     // }
//   }

// }
