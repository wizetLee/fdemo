import 'package:fdemo/gesture_widget/jz_range_view.dart';
import 'package:fdemo/nest_scroll_view/nest_scroll_view_route.dart';
import 'package:flutter/material.dart';

///
class ScrollbarWidget extends StatefulWidget {
  const ScrollbarWidget({Key? key}) : super(key: key);

  @override
  State<ScrollbarWidget> createState() => _ScrollbarWidgetState();
}

class _ScrollbarWidgetState extends State<ScrollbarWidget> with SingleTickerProviderStateMixin{
  var title = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _body2(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  late var tabController = TabController(length: 3, vsync: this);
  Widget _body2() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 150,
                color: Colors.yellow.withOpacity(0.5),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                color: Colors.yellow.withOpacity(0.5),
                child: TabBar(controller: tabController, tabs: [
                  Text("1"),
                  Text("2"),
                  Text("3"),
                ],),
              ),
            ),
            // 监听计算高度，并且通过 NestedScrollView._absorberHandle 将
            // 自身的高度 告诉 SliverOverlapInjector
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: SliverPersistentHeaderDelegateExtends(),
                pinned: true,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            ccc(),
            ccc(),
            ccc(),
          ],
        ));
  }

  Widget ccc() {
    return Builder(builder: (BuildContext context) {
      return Scrollbar(
        child: CustomScrollView(
          // The "controller" and "primary" members should be left
          // unset, so that the NestedScrollView can control this
          // inner scroll view.
          // If the "controller" property is set, then this scroll
          // view will not be associated with the NestedScrollView.
          slivers: <Widget>[
            // 占位，接收 SliverOverlapAbsorber 的信息
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverFixedExtentList(
              itemExtent: 48.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    ListTile(title: Text('Item $index')),
                childCount: 130,
              ),
            ),
          ],
        ),
      );
    });
  }
}
