/*
 * flutter_ui_demo 
 * main_ui_page.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/pages/tabbar/max_page.dart';
import 'package:flutter_ui_demo/pages/tabbar/min_page.dart';
import 'package:flutter_ui_demo/pages/tabbar/mid_page.dart';
import 'package:flutter_ui_demo/utils/splash_hide_factory.dart';

class MainUiPage extends StatefulWidget {
  const MainUiPage({Key? key}) : super(key: key);

  @override
  _MainUiPageState createState() => _MainUiPageState();
}

class _MainUiPageState extends State<MainUiPage> {
  // MARK:
  int selectedIndex = 0;

  static List<Widget> pageList = <Widget>[
    MaxPage(title: "Home"),
    MidPage(title: "Course"),
    MinPage(title: "Mine"),
  ];

  static List<BottomNavigationBarItem> itemList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.access_alarms, color: Colors.black, size: 20),
      activeIcon: Icon(Icons.access_alarms, color: Colors.blue, size: 20),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark, color: Colors.black, size: 20),
      activeIcon: Icon(Icons.bookmark, color: Colors.blue, size: 20),
      label: "课程",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book, color: Colors.black, size: 20),
      activeIcon: Icon(Icons.book, color: Colors.blue, size: 20),
      label: "我的",
    ),
  ];

  // MARK:
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashFactory: SplashHideFactory(), // 移除波纹效果
          highlightColor: Colors.transparent, // 移除点击效果
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          fixedColor: Colors.blue,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: itemList,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
      body: pageList[selectedIndex],
      backgroundColor: Colors.white,
    );
  }
}
