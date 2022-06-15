import 'package:flutter/material.dart';


/// 点击项
class JZSegmentedItem extends StatelessWidget {
  static Color selectedBGColor =
  const Color(0xFFFFF2F4); // const Color(0xFD263F).withOpacity(0.06);
  static Color selectedTextColor = const Color(0xFFFD263F);
  static Color normalBGColor = const Color(0xFFF7F7F7);
  static Color normalTextColor = const Color(0xFF999999);

  final double spacing;
  final bool isSelected;
  final String text;

  const JZSegmentedItem(
      {required this.text,
        required this.isSelected,
        this.spacing = 8,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSelected = this.isSelected;
    var bgColor = isSelected
        ? JZSegmentedItem.selectedBGColor
        : JZSegmentedItem.normalBGColor;
    var textColor = isSelected
        ? JZSegmentedItem.selectedTextColor
        : JZSegmentedItem.normalTextColor;
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
