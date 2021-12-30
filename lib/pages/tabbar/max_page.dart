/*
 * flutter_ui_demo 
 * max_page.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widget/tabbar/tabbar_cover.dart';
import 'package:flutter_ui_demo/utils/share_manager.dart';

class MaxPage extends StatefulWidget {
  MaxPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MaxPageState createState() => _MaxPageState();
}

class _MaxPageState extends State<MaxPage> with TickerProviderStateMixin {
  // MARK:
  TabController? _tabController1;
  TabController? _tabController2;

  // MARK:
  @override
  void initState() {
    super.initState();

    _tabController1 = TabController(length: 3, vsync: this);
    _tabController1?.addListener(() {
      if (_tabController1?.indexIsChanging == true) {
        var previousIndex = _tabController1?.previousIndex;
        var index = _tabController1?.index;
        print('Listener1 indexIsChanging - $previousIndex To $index');
      }
    });

    _tabController2 = TabController(length: 3, vsync: this);
    _tabController2?.addListener(() {
      if (_tabController2?.indexIsChanging == true) {
        var previousIndex = _tabController2?.previousIndex;
        var index = _tabController2?.index;
        print('Listener2 indexIsChanging - $previousIndex To $index');
      }
    });
  }

  @override
  void dispose() {
    _tabController1?.dispose();
    _tabController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Test
    someTestFunc();

    //Widget
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cover Indicator. Fill"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController1,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: CoverIndicator(
                  bottomLeftRadius: 100,
                  bottomRightRadius: 100,
                  topLeftRadius: 100,
                  topRightRadius: 100,
                  paintingStyle: PaintingStyle.fill,
                ),
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cover Indicator. Stroke"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController2,
                labelColor: Colors.black,
                indicator: CoverIndicator(
                  bottomLeftRadius: 100,
                  bottomRightRadius: 100,
                  topLeftRadius: 100,
                  topRightRadius: 100,
                  paintingStyle: PaintingStyle.stroke,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void someTestFunc() {
    print("SomeThing Default:" + ShareManager().someThing);
    ShareManager().someThing = "Max";
    print("SomeThing Change:" + ShareManager().someThing);
  }
}
