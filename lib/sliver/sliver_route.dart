/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2024/7/18 14:27 
* @Description :
*/

import 'package:flutter/material.dart';

class SliverRoute extends StatefulWidget {
  const SliverRoute({super.key});

  @override
  State<SliverRoute> createState() => _SliverRouteState();
}

class _SliverRouteState extends State<SliverRoute> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: _body(),
    // );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Outer NestedScrollView"),
                background: Image.network(
                  'https://via.placeholder.com/800x400',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: InnerNestedScrollView(),
      ),
    );
  }

  Widget _body() {
    return SliverExamplePage();
  }
}

class SliverExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Sliver Example"),
              // background: Image.network(
              //   'https://via.placeholder.com/800x400',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This is a SliverToBoxAdapter. You can put any widget here.',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     mainAxisSpacing: 10.0,
          //     crossAxisSpacing: 10.0,
          //     childAspectRatio: 1.0,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return Container(
          //         color: Colors.teal[100 * (index % 9)],
          //         child: Center(
          //           child: Text('$index'),
          //         ),
          //       );
          //     },
          //     childCount: 30,
          //   ),
          // ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('Item $index'),
                );
              },
              childCount: 10,
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: JzSilverAppBarDelegate(PreferredSize(
                  preferredSize: const Size.fromHeight(59),
                  child: Container(
                    color: Colors.orange,
                    width: double.infinity,
                    height: double.infinity,
                  )))),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('Item $index'),
                );
              },
              childCount: 10,
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('List Item $index'),
                  leading: Icon(Icons.star),
                );
              },
              childCount: 20,
            ),
          ),
          // SliverFixedExtentList(
          //   itemExtent: 50.0,
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return Container(
          //         alignment: Alignment.center,
          //         color: Colors.lightBlue[100 * (index % 9)],
          //         child: Text('Item $index'),
          //       );
          //     },
          //     childCount: 10,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class JzSilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  JzSilverAppBarDelegate(this._preferredSize);

  final PreferredSize _preferredSize;

  @override
  double get minExtent => _preferredSize.preferredSize.height;

  @override
  double get maxExtent => _preferredSize.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _preferredSize,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


class InnerNestedScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CustomScrollView(
    //   slivers: <Widget>[
    //     SliverToBoxAdapter(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           'This is inside the inner NestedScrollView.',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //       ),
    //     ),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //           return ListTile(
    //             title: Text('Item $index'),
    //             leading: Icon(Icons.star),
    //           );
    //         },
    //         childCount: 15,
    //       ),
    //     ),
    //   ],
    // );
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Inner NestedScrollView"),
              background: Image.network(
                'https://via.placeholder.com/600x300',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: Container(),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(
      //           'This is inside the inner NestedScrollView.',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //             (BuildContext context, int index) {
      //           return ListTile(
      //             title: Text('Item $index'),
      //             leading: Icon(Icons.star),
      //           );
      //         },
      //         childCount: 15,
      //       ),
      //     ),
      //   ],
      // ),
    );

  }
}
