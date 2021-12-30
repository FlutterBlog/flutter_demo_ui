/*
 * flutter_ui_demo 
 * home_net_page.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/net/net_utils.dart';
import 'package:flutter_ui_demo/pages/net_demo/net_utils_home.dart';

class HomeNetPage extends StatefulWidget {
  HomeNetPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeNetPageState createState() => _HomeNetPageState();
}

class _HomeNetPageState extends State<HomeNetPage> {
  // MARK:

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
    //Test
    someTestFunc();
    someTestNet();

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
          ],
        ),
      ),
    );
  }

  void someTestFunc() {
    HomeNetUtils.requestRepoList(
      success: (result) {
        print('Success.');
      },
      error: (errorCode, errorMsg) {
        print('Error.' + errorMsg);
      },
    );

    // HomeNetUtils.requestRepoDetail(
    //   success: (result) {
    //     print('Success.');
    //   },
    //   error: (errorCode, errorMsg) {
    //     print('Error.' + errorMsg);
    //   },
    // );

    // HomeNetUtils.requestRepoIssues(
    //   success: (result) {
    //     print('Success.');
    //   },
    //   error: (errorCode, errorMsg) {
    //     print('Error.' + errorMsg);
    //   },
    // );
  }

  void someTestNet() {
    // NetUtils.requestUser('ConnyYue')(
    //   success: (result) {
    //     print('Success.');
    //   },
    //   error: (errorCode, errorMsg) {
    //     print('Error.' + errorMsg);
    //   },
    // );

    // NetUtils.requestSearch('Flutter')(
    //   success: (result) {
    //     print('Success.');
    //   },
    //   error: (errorCode, errorMsg) {
    //     print('Error.' + errorMsg);
    //   },
    // );
  }
}
