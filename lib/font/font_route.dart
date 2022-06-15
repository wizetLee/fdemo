import 'package:flutter/material.dart';

class FontRouteItem {
  String title;
  TextStyle style;
  FontRouteItem({required this.title, required this.style});
}

class FontRoute extends StatefulWidget {
  const FontRoute({Key? key}) : super(key: key);

  @override
  State<FontRoute> createState() => _FontRouteState();
}

class _FontRouteState extends State<FontRoute> {
  var boldStyle = const TextStyle(
    fontFamily: 'DINPro-Bold',
  );

  var mediumStyle = const TextStyle(
    fontFamily: 'DINPro-Medium',
  );

  var regularStyle = const TextStyle(
    fontFamily: 'DINPro-Regular',
  );

  var textRegularStyle = const TextStyle(
    fontFamily: 'SF UI Display',
  );
  var textMediumStyle =
      const TextStyle(fontFamily: 'SF UI Display', fontWeight: FontWeight.w500);
  var textBoldStyle =
      const TextStyle(fontFamily: 'SF UI Display', fontWeight: FontWeight.w700);
  var w100 = const TextStyle(
      fontWeight: FontWeight.w100, fontFamilyFallback: ["PingFang SC"]);
  var w200 = const TextStyle(
      fontWeight: FontWeight.w200, fontFamilyFallback: ["PingFang SC"]);
  var w300 = const TextStyle(
      fontWeight: FontWeight.w300, fontFamilyFallback: ["PingFang SC"]);
  var w400 = const TextStyle(
      fontWeight: FontWeight.w400, fontFamilyFallback: ["PingFang SC"]);
  var w500 = const TextStyle(
      fontWeight: FontWeight.w500, fontFamilyFallback: ["PingFang SC"]);
  var w600 = const TextStyle(
      fontWeight: FontWeight.w600, fontFamilyFallback: ["PingFang SC"]);
  var w700 = const TextStyle(
      fontWeight: FontWeight.w700, fontFamilyFallback: ["PingFang SC"]);
  var w800 = const TextStyle(
      fontWeight: FontWeight.w800, fontFamilyFallback: ["PingFang SC"]);
  var w900 = const TextStyle(
      fontWeight: FontWeight.w900, fontFamilyFallback: ["PingFang SC"]);

  @override
  Widget build(BuildContext context) {
    List<FontRouteItem> items = [];
    {
      var title = "1234567890";
      this.add(items, title);
    }
    {
      var title = "!!@@##\$\$%%^^&&**（（））()__++--==";
      this.add(items, title);
    }
    {
      var title = "abcdefghijklmnopqrstuvwxyz";
      this.add(items, title);
    }
    {
      var title = "在线中文测试";
      this.add(items, title);
    }
    return Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (view, index) {
            return Container(
              child: Text(
                items[index].title,
                style: items[index]
                    .style
                    .copyWith(fontSize: 20, decoration: TextDecoration.none),
              ),
            );
          },
          itemCount: items.length,
        ));
  }

  void add(List<FontRouteItem> items, String title) {
    final bold = FontRouteItem(title: title, style: boldStyle);
    items.add(bold);
    final medium = FontRouteItem(title: title, style: mediumStyle);
    items.add(medium);
    final regular = FontRouteItem(title: title, style: regularStyle);
    items.add(regular);
    final textBold = FontRouteItem(title: title, style: textBoldStyle);
    items.add(textBold);
    final textMedium = FontRouteItem(title: title, style: textMediumStyle);
    items.add(textMedium);
    final textRegular = FontRouteItem(title: title, style: textRegularStyle);
    items.add(textRegular);

    final w100Item = FontRouteItem(title: title, style: w100);
    items.add(w100Item);
    final w200Item = FontRouteItem(title: title, style: w200);
    items.add(w200Item);
    final w300Item = FontRouteItem(title: title, style: w300);
    items.add(w300Item);
    final w400Item = FontRouteItem(title: title, style: w400);
    items.add(w400Item);
    final w500Item = FontRouteItem(title: title, style: w500);
    items.add(w500Item);
    final w600Item = FontRouteItem(title: title, style: w600);
    items.add(w600Item);
    final w700Item = FontRouteItem(title: title, style: w700);
    items.add(w700Item);
    final w800Item = FontRouteItem(title: title, style: w800);
    items.add(w800Item);
    final w900Item = FontRouteItem(title: title, style: w900);
    items.add(w900Item);
  }
}
