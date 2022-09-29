import 'package:flutter/material.dart';

class NestScrollViewRoute extends StatefulWidget {
  const NestScrollViewRoute({Key? key}) : super(key: key);

  @override
  State<NestScrollViewRoute> createState() => _NestScrollViewRouteState();
}

class _NestScrollViewRouteState extends State<NestScrollViewRoute> with SingleTickerProviderStateMixin {

  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return
      RefreshIndicator(
        notificationPredicate: (notification) {
          print("notification = $notification  notification.depth = ${notification.depth}");
          if (notification.depth == 1) {
            return true;
          }
          return false
          ;
        },
        onRefresh: () async {
          print("object");
        },
        child:
      NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            print("headerSliverBuilder closure  --- innerBoxIsScrolled = $innerBoxIsScrolled");
            //SliverPersistentHeader()
            return [
              // 可折叠的头布局
              SliverAppBar(title:
              Text("xxx",),
                // elevation: 300,
                pinned: false,
                floating: true,

                // 控制在下滑的时候 appBar是否快速呈现
                // snap: false,
                // snap: false,

                // , centerTitle: "xxx",
                bottom: TempPreferredSizeWidget(),
                flexibleSpace: Container(height: 1000, color: Colors.orange,),
              ),

              // SliverToBoxAdapter(child:
              //   Container(height: 122, color: Colors.orange,),
              // ),

              // 不能
              // SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateExtends(), pinned: true,)
            ];
          },
          body:
          ListView.builder(itemBuilder: (context, index) {
            return ListTile(title: Text("测试 $index"),);
          },
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
          )
        // Container(color: Colors.yellow,),
      )
    );
  }
}

class SliverPersistentHeaderDelegateExtends extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    throw Container(height: 1000, color: Colors.blue,);
  }

  @override
  double get maxExtent => 1000;

  @override
  double get minExtent => 1000;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // // TODO: implement shouldRebuild
    // throw UnimplementedError();
    return true;
  }

}



class TempPreferredSizeWidget extends StatelessWidget with PreferredSizeWidget {

  const TempPreferredSizeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.greenAccent.withOpacity(0.5),
    );
  }

  @override
  Size get preferredSize => Size(100, 1000) ;
}

