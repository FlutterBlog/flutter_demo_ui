/*
 * flutter_ui_demo 
 * mid_page.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widget/tabbar/tabbar_dot.dart';
import 'package:flutter_ui_demo/utils/share_manager.dart';

class MidPage extends StatefulWidget {
  MidPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MidPageState createState() => _MidPageState();
}

class _MidPageState extends State<MidPage> with TickerProviderStateMixin {
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
              child: Text("Dot Indicator. Default"),
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
                controller: _tabController1,
                labelColor: Colors.black,
                indicator: DotIndicator(),
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text("Dot Indicator. Custom"),
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
                labelColor: Colors.blueGrey,
                indicator: DotIndicator(
                  color: Colors.lightBlue,
                  distanceFromCenter: 16,
                  radius: 5,
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
    ShareManager().someThing = "Mid";
    print("SomeThing Change:" + ShareManager().someThing);
  }
}
