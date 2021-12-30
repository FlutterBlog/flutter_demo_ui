import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'flutter_refresh_header.dart';

class AppRefreshController {
  // 刷新控制器
  final EasyRefreshController _refreshController = EasyRefreshController();

  /// 触发刷新
  void callRefresh() {
    _refreshController.callRefresh();
  }

  /// 触发加载
  void callLoad() {
    _refreshController.callLoad();
  }

  /// 结束刷新和加载
  void finish({bool noMoreData = false}) {
    finishRefresh();
    finishLoad(noMoreData: noMoreData);
  }

  /// 结束刷新
  void finishRefresh() {
    _refreshController.finishRefresh(success: true, noMore: false);
  }

  /// 结束加载
  void finishLoad({bool noMoreData = false}) {
    _refreshController.finishLoad(success: true, noMore: noMoreData);
  }

  /// 销毁
  void dispose() {
    _refreshController.dispose();
  }
}

class AppRefresh extends StatefulWidget {
  // 刷新的组件
  final Widget child;

  // 刷新控制器
  final AppRefreshController controller;

  // header
  final Header? header;

  // 刷新回调
  final VoidCallback? onRefresh;

  // 加载回调
  final VoidCallback? onLoad;

  AppRefresh({
    required this.child,
    required this.controller,
    this.onLoad,
    this.onRefresh,
    this.header,
  }) : assert(controller != null, "刷新控制器不得为空");

  @override
  _AppRefreshState createState() => _AppRefreshState();
}

class _AppRefreshState extends State<AppRefresh> {
  /// Header
  final Header _defaultHeader = RefreshHeader();

  final Header _defaultHeaders = ClassicalHeader(
    refreshText: '下拉刷新',
    refreshReadyText: '松开刷新',
    refreshingText: '刷新中...',
    refreshedText: '已刷新',
    infoText: '上次更新:%T',
    infoColor: Color(0xFF999999),
    bgColor: Colors.transparent,
    textColor: Colors.black,
    enableHapticFeedback: false,
  );

  /// Footer
  final Footer _defaultFooter = ClassicalFooter(
    extent: 50.0,
    loadText: '上拉加载',
    loadReadyText: '松开加载',
    loadingText: '加载中...',
    loadedText: '已加载',
    noMoreText: '没有更多数据了',
    loadFailedText: '啊哦，加载失败了',
    infoText: '上次更新:%T',
    infoColor: Color(0xFF999999),
    bgColor: Colors.transparent,
    textColor: Colors.black,
    enableHapticFeedback: false,
  );

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: widget.child,
      controller: widget.controller._refreshController,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      header: widget.header != null ? widget.header : _defaultHeader,
      footer: _defaultFooter,
      onRefresh: widget.onRefresh == null
          ? null
          : () async {
              return Future.delayed(
                const Duration(seconds: 0),
                () {
                  widget.onRefresh?.call();
                },
              );
            },
      onLoad: widget.onLoad == null
          ? null
          : () async {
              return Future.delayed(
                const Duration(seconds: 0),
                () {
                  widget.onLoad?.call();
                },
              );
            },
    );
  }
}
