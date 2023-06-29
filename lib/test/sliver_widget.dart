

import 'package:fdemo/nest_scroll_view/nest_scroll_view_route.dart';
import 'package:flutter/material.dart';

class SliverWidgetRoute extends StatefulWidget {
  const SliverWidgetRoute({Key? key}) : super(key: key);

  @override
  State<SliverWidgetRoute> createState() => _SliverWidgetRouteState();
}

class _SliverWidgetRouteState extends State<SliverWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: _body(),
    );
  }

  _body() {
    return _test();
  }

  // 还没达到要求！！！！！
  _test() {
    // 多层的
    return CustomScrollView(slivers: [
      SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateContainer(), pinned: true, floating: true),
      SliverToBoxAdapter(child: Container(height: 10, color: Colors.orange,),),
      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(height: 10, color: Colors.green,);
        return null;
      }, childCount: 1),),

      SliverToBoxAdapter(child: Container(height: 10, color: Colors.orange,),),
      SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateContainer(), pinned: true, floating: false,),
      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(height: 10, color: Colors.green,);
        return null;
      }, childCount: 1),),

      //SliverFixedExtentList(delegate: delegate, itemExtent: itemExtent)
      SliverToBoxAdapter(child: Container(height: 10, color: Colors.orange,),),
      SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateContainer(), pinned: true, floating: false),
      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(height: 10, color: Colors.green,);
        return null;
      }, childCount: 1),),
    ],);
  }
}

class SliverPersistentHeaderDelegateContainer
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Builder(builder: (context) {
      return Container(
        child: Center(child: Text(
          "hello world",
          style: TextStyle(color: Colors.white),
        ),),
        color: Colors.blue,
      );
    });
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;
  // double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // // TODO: implement shouldRebuild
    // throw UnimplementedError();
    return false;
  }
}
