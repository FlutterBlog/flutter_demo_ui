import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'flutter_refresh_anim.dart';

///通用header
class RefreshHeader extends Header {
  RefreshHeader({
    double extent = 60,
    double triggerDistance = 70,
  }) : super(extent: extent, triggerDistance: triggerDistance);

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    return DHeaderWidget(refreshState: refreshState);
  }
}

class DHeaderWidget extends StatefulWidget {
  final RefreshMode? refreshState;
  DHeaderWidget({this.refreshState});

  @override
  _RefreshHeaderState createState() => _RefreshHeaderState();
}

class _RefreshHeaderState extends State<DHeaderWidget>
    with TickerProviderStateMixin {
  late AppRefreshAnimController controller;
  bool isAnimating = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didUpdateWidget(DHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller == null) {
      return;
    }
    if (widget.refreshState == RefreshMode.done ||
        widget.refreshState == RefreshMode.inactive) {
      controller.stop();
      isAnimating = false;
    } else {
      if (!isAnimating) {
        controller.start();
        isAnimating = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AppRefreshAnimController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      alignment: Alignment.bottomCenter,
      child: AppRefreshAnimWidget(
        // 可用自己的headerWidget，此处为示例
        size: Size.fromHeight(20),
        radius: 4,
        space: 8,
        duration: Duration(milliseconds: 300),
        controller: controller,
      ),
    );
  }
}
