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

  @override
  Widget build(BuildContext context) {

    List<FontRouteItem> items = [];
    {
      var title = "1234567890";
      final bold = FontRouteItem(title: title, style: boldStyle);
      items.add(bold);
      final medium = FontRouteItem(title: title, style: mediumStyle);
      items.add(medium);
      final regular = FontRouteItem(title: title, style: regularStyle);
      items.add(regular);
      final normal = FontRouteItem(title: title, style: TextStyle());
      items.add(normal);
    }
    {
      var title = "!!@@##\$\$%%^^&&**（（））()__++--==";
      final bold = FontRouteItem(title: title, style: boldStyle);
      items.add(bold);
      final medium = FontRouteItem(title: title, style: mediumStyle);
      items.add(medium);
      final regular = FontRouteItem(title: title, style: regularStyle);
      items.add(regular);
      final normal = FontRouteItem(title: title, style: TextStyle());
      items.add(normal);
    }
    {
      var title = "abcdefghijklmnopqrstuvwxyz";
      final bold = FontRouteItem(title: title, style: boldStyle);
      items.add(bold);
      final medium = FontRouteItem(title: title, style: mediumStyle);
      items.add(medium);
      final regular = FontRouteItem(title: title, style: regularStyle);
      items.add(regular);
      final normal = FontRouteItem(title: title, style: TextStyle());
      items.add(normal);
    }
    {
      var title = "在线中文测试";
      final bold = FontRouteItem(title: title, style: boldStyle);
      items.add(bold);
      final medium = FontRouteItem(title: title, style: mediumStyle);
      items.add(medium);
      final regular = FontRouteItem(title: title, style: regularStyle);
      items.add(regular);
      final normal = FontRouteItem(title: title, style: TextStyle());
      items.add(normal);
    }
    return Container(
      color: Colors.white,
        child: ListView.builder(
      itemBuilder: (view, index) {
        return Container(
          child: Text(
            items[index].title,
            style: items[index].style.copyWith(fontSize: 18, decoration: TextDecoration.none),
          ),
        );
      },
      itemCount: items.length,
    ));
  }
}
