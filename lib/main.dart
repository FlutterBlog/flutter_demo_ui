/*
 * flutter_ui_demo 
 * main.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
// import 'package:flutter_ui_demo/roots/main_tabbar_page.dart';
import 'package:flutter_ui_demo/pages/net_demo/home_net_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeNetPage(title: "网络测试页"),
      // home: MainTabbarPage(),
    );
  }
}
