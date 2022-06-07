import 'package:flutter/material.dart';

class FontRoute extends StatefulWidget {
  const FontRoute({Key? key}) : super(key: key);

  @override
  State<FontRoute> createState() => _FontRouteState();
}

class _FontRouteState extends State<FontRoute> {
  // fonts:
  //   - family: DINPro-Bold
  //     fonts:
  //       - asset: asset/fonts/DINProBold.otf
  //   - family: DINPro-Medium
  //     fonts:
  //       - asset: assets/fonts/DINProMedium.otf
  //   - family: DINPro-Regular
  //     fonts:
  //       - asset: assets/fonts/DINProRegular.otf

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
    List<String> titles = [
      "1111",
      "123123123123",
      "sadasdasdsa",
      "dpqwoeqpwonfdsobvxc",
      ",./[]{}.,,.",
      "的骚动牛皮的物品请大家去外婆额我去哦你骗我的"
    ];

    var style =
        mediumStyle.copyWith(fontSize: 18, decoration: TextDecoration.none);
    style =
        regularStyle.copyWith(fontSize: 18, decoration: TextDecoration.none);
    style = boldStyle.copyWith(fontSize: 18, decoration: TextDecoration.none);
    style = TextStyle(fontSize: 18, decoration: TextDecoration.none);
    return Container(
        child: ListView.builder(
      itemBuilder: (view, index) {
        return Container(
          child: Text(
            titles[index],
            style: style,
          ),
        );
      },
      itemCount: titles.length,
    ));
  }
}
