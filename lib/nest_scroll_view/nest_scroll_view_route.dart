import 'package:flutter/material.dart';

class NestScrollViewRoute extends StatefulWidget {
  const NestScrollViewRoute({Key? key}) : super(key: key);

  @override
  State<NestScrollViewRoute> createState() => _NestScrollViewRouteState();
}

class _NestScrollViewRouteState extends State<NestScrollViewRoute>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body2(),
      // body: _body4(),
    );
  }

  Widget _body4() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            child: Text('Header0: 100高度'),
            height: 100,
            color: Colors.yellow.withOpacity(0.4),
          ),
        ),
        SliverPersistentHeader(
          delegate: SliverPersistentHeaderDelegateExtends(),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            child: Text('Header2: 100高度'),
            height: 100,
            color: Colors.yellow.withOpacity(0.4),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            children: <Widget>[
              // 我相当于 SliverOverlapAbsorber
              Container(
                height: 100,
              ),
              Column(
                children: List.generate(
                    1,
                        (index) => Container(
                      alignment: Alignment.topCenter,
                      child: Text('body: 里面的内容$index,高度100'),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.4),
                          border: Border.all(
                            color: Colors.black,
                          )),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _body2() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverToBoxAdapter(child: Container(height: 50,
        color: Colors.yellow.withOpacity(0.5),
        ),),
        // 监听计算高度，并且通过 NestedScrollView._absorberHandle 将
        // 自身的高度 告诉 SliverOverlapInjector
        SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver:
            SliverPersistentHeader(
              delegate: SliverPersistentHeaderDelegateExtends(),
              pinned: true,
            ),
        )
      ];
    }, body: Builder(builder: (BuildContext context) {
      return CustomScrollView(
        // The "controller" and "primary" members should be left
        // unset, so that the NestedScrollView can control this
        // inner scroll view.
        // If the "controller" property is set, then this scroll
        // view will not be associated with the NestedScrollView.
        slivers: <Widget>[
          // 占位，接收 SliverOverlapAbsorber 的信息
          SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverFixedExtentList(
            itemExtent: 48.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  ListTile(title: Text('Item $index')),
              childCount: 30,
            ),
          ),
        ],
      );
    }));
  }

  Widget _body3() {
    return Column(
      children: [
        Container(height: 100,),
        Expanded(
            child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   pinned: true,
              //   expandedHeight: 100,
              //   flexibleSpace: FlexibleSpaceBar(
              //     title: const Text("SliverAppBar"),
              //   ),
              // ),
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate: MySliverPersistentHeaderDelegate(),
              // ),
              SliverPersistentHeader(
                delegate: SliverPersistentHeaderDelegateExtends(),
                pinned: true,
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //         (context, index) {
              //       return Container(
              //         height: 50,
              //         color: Colors.primaries[index % Colors.primaries.length],
              //       );
              //     },
              //     childCount: 100,
              //   ),
              // ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: Colors.primaries[index % Colors.primaries.length],
                    );
                  },
                  childCount: 200,
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }

  Widget _body() {
    return RefreshIndicator(
        notificationPredicate: (notification) {
          print(
              "notification = $notification  notification.depth = ${notification.depth}");
          if (notification.depth == 1) {
            return true;
          }
          return false;
        },
        onRefresh: () async {
          print("object");
        },
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              print(
                  "headerSliverBuilder closure  --- innerBoxIsScrolled = $innerBoxIsScrolled");
              //SliverPersistentHeader()
              return [
                // 可折叠的头布局
                SliverAppBar(
                  title: Text(
                    "xxx",
                  ),
                  // elevation: 300,
                  pinned: true,
                  floating: false,

                  // 控制在下滑的时候 appBar是否快速呈现
                  // snap: false,
                  // snap: true,

                  // , centerTitle: "xxx",
                  bottom: TempPreferredSizeWidget(),
                  flexibleSpace: Container(
                    height: 1000,
                    color: Colors.orange,
                  ),
                ),

                // SliverToBoxAdapter(child:
                //   Container(height: 122, color: Colors.orange,),
                // ),

                SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateExtends(), pinned: true,),
                SliverPersistentHeader(delegate: SliverPersistentHeaderDelegateExtends(), pinned: true,)
              ];
            },
            body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("测试 $index"),
                );
              },
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
            )
            // Container(color: Colors.yellow,),
            ));
  }
}

class SliverPersistentHeaderDelegateExtends
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
          color: Colors.blue.withOpacity(0.5),
        );
    });
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;
  // double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // // TODO: implement shouldRebuild
    // throw UnimplementedError();
    return false;
  }
}

class TempPreferredSizeWidget extends StatelessWidget with PreferredSizeWidget {
  const TempPreferredSizeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.greenAccent.withOpacity(0.5),
    );
  }

  @override
  Size get preferredSize => Size(100, 100);
}
