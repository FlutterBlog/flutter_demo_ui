/*
 * flutter_ui_demo 
 * min_page.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widget/tabbar/tabbar_line.dart';
import 'package:flutter_ui_demo/utils/share_manager.dart';

class MinPage extends StatefulWidget {
  MinPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MinPageState createState() => _MinPageState();
}

class _MinPageState extends State<MinPage> with TickerProviderStateMixin {
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
              padding: const EdgeInsets.all(6.0),
              child: Text("Line Indicator. Default"),
            ),
            Material(
              child: TabBar(
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController1,
                labelColor: Colors.blueGrey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: LineIndicator(color: Colors.blue),
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text("Line Indicator. Bottom"),
            ),
            Material(
              child: TabBar(
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController1,
                labelColor: Colors.blueGrey,
                indicator: LineIndicator(
                  height: 4,
                  topLeftRadius: 2,
                  topRightRadius: 2,
                  bottomLeftRadius: 2,
                  bottomRightRadius: 2,
                  horizontalPadding: 55,
                  color: Colors.blue,
                  tabPosition: TabPosition.bottom,
                ),
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text("Line Indicator. Bottom"),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TabBar(
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController2,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: LineIndicator(
                  height: 4,
                  bottomLeftRadius: 4,
                  bottomRightRadius: 4,
                  tabPosition: TabPosition.bottom,
                ),
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text("Line Indicator. Top"),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TabBar(
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Course"),
                  Tab(text: "Mine"),
                ],
                controller: _tabController2,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: LineIndicator(
                  height: 4,
                  topLeftRadius: 4,
                  topRightRadius: 4,
                  tabPosition: TabPosition.top,
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
    ShareManager().someThing = "Min";
    print("SomeThing Change:" + ShareManager().someThing);
  }
}
