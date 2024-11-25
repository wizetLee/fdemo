/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2024/1/28 13:47 
* @Description :
*/

import 'package:flutter/material.dart';
import 'package:fdemo/overlay/jz_overlay_manager.dart';

///
class MyOverlayRoute extends StatefulWidget {
  const MyOverlayRoute({Key? key}) : super(key: key);

  @override
  State<MyOverlayRoute> createState() => _MyOverlayRouteState();
}

class _MyOverlayRouteState extends State<MyOverlayRoute> {
  var title = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Overlay"),
      ),
      body: _scaffoldBody(),
    );
  }
}

extension _TemplateRouteStateWidget on _MyOverlayRouteState {
  Widget _scaffoldBody() {
    JZOverlayManager.instance;
    return _body();
  }

  Widget _body() {
    OverlayEntry(builder: (context) {
      return Container(
        width: 20,
        height: 20,
      );
    });
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            //FIXME:
            JZOverlayManager.instance.showOverlay((context) {
              return Positioned(
                //减去了文字一半的长度，让tips居中，这个位置可以自己根据需求调整
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.orange,
                  width: 199,
                  height: 66,
                  padding: const EdgeInsets.only(
                      top: 11, bottom: 7, left: 8, right: 8),
                  child: Text(
                    "？？？",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            }, context: context);
            JZOverlayManager.instance.showOverlay((context) {
              return Positioned(
                //减去了文字一半的长度，让tips居中，这个位置可以自己根据需求调整
                left: 0,
                bottom: 0,
                child: Container(
                  color: Colors.orange,
                  width: 199,
                  height: 66,
                  padding: const EdgeInsets.only(
                      top: 11, bottom: 7, left: 8, right: 8),
                  child: Text(
                    "？？？",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            }, context: context);
          },
          child: Text("按钮"),
        ),
      ),
    );
  }
}

extension _TemplateRouteStateNetWork on _MyOverlayRouteState {}

extension _TemplateRouteStatePrivate on _MyOverlayRouteState {}
