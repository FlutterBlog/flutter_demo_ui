import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRefreshAnimWidget extends StatefulWidget {
  ///球间距
  final double space;

  ///球半径
  final double radius;

  ///背景颜色
  final Color bgColor;

  ///球填充颜色
  final Color ballColor;

  ///从底部运动到顶部的时间
  final Duration duration;

  ///组件大小
  final Size size;

  ///动画插值器
  final Curve curve;

  ///是否自动执行动画
  final bool isAutoPlay;

  final AppRefreshAnimController controller;

  AppRefreshAnimWidget(
      {required this.controller,
      this.space = 10,
      this.radius = 5,
      this.bgColor = Colors.transparent,
      this.ballColor = Colors.black,
      this.duration = const Duration(milliseconds: 300),
      this.size = const Size.fromHeight(40.0),
      this.isAutoPlay = false,
      this.curve = Curves.linear})
      : assert(space != null),
        assert(radius != null),
        assert(bgColor != null),
        assert(ballColor != null),
        assert(duration != null),
        assert(size != null),
        assert(curve != null);

  @override
  _AppRefreshAnimState createState() {
    return _AppRefreshAnimState();
  }
}

class _AppRefreshAnimState extends State<AppRefreshAnimWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: widget.duration,
        reverseDuration: widget.duration,
        vsync: this);
    curvedAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    curvedAnimation.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    if (widget.isAutoPlay) {
      _controller.repeat(reverse: true);
    }

    widget.controller._onStartCallback = () {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    };

    widget.controller._onStopCallback = () {
      if (_controller.isAnimating) {
        _controller.stop();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AppRefreshAnimPaint(
        curvedAnimation.value,
        curvedAnimation.status == AnimationStatus.forward
            ? _MoveDirection.down //动画正向执行，球体向下移动
            : _MoveDirection.up, //动画逆向执行，球体向上移动
        space: widget.space,
        radius: widget.radius,
        ballColor: widget.ballColor,
        bgColor: widget.bgColor,
      ),
      size: widget.size,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AppRefreshAnimPaint extends CustomPainter {
  final double space;
  final double radius;
  final double value;
  final _MoveDirection direction;
  final Color bgColor;
  final Color ballColor;

  _AppRefreshAnimPaint(this.value, this.direction,
      {this.space = 10.0,
      this.radius = 5.0,
      this.bgColor = Colors.transparent,
      this.ballColor = Colors.black});

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    //可运动范围
    double moveDistance = size.height - 2 * radius;
    if (moveDistance <= 0) {
      return;
    }
    //第一个球的距底部距离
    double firstBallDistanceFromBottom = value;
    //第二个球的距底部距离
    double secondBallDistanceFromBottom = value;

    if (direction == _MoveDirection.up) {
      //向上运动
      if (value < 0.5) {
        secondBallDistanceFromBottom = value + 0.5;
      } else {
        secondBallDistanceFromBottom = 1 - (value - 0.5);
      }
    } else if (direction == _MoveDirection.down) {
      //向下运动
      if (value < 0.5) {
        secondBallDistanceFromBottom = 0.5 - value;
      } else {
        secondBallDistanceFromBottom = value - 0.5;
      }
    }
    //第三个球的距底部距离
    double thirdBallDistanceFromBottom = (1 - value);
    _paint.color = bgColor;
    _paint.style = PaintingStyle.fill;
    //绘制背景
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), _paint);
    _paint.color = ballColor;

    //绘制第一个球
    canvas.drawCircle(
        Offset(size.width / 2 - 2 * radius - space,
            firstBallDistanceFromBottom * moveDistance + radius),
        radius,
        _paint);

    //绘制第二个球
    canvas.drawCircle(
        Offset(size.width / 2,
            secondBallDistanceFromBottom * moveDistance + radius),
        radius,
        _paint);

    //绘制第三个球
    canvas.drawCircle(
        Offset(size.width / 2 + 2 * radius + space,
            thirdBallDistanceFromBottom * moveDistance + radius),
        radius,
        _paint);
  }

  @override
  bool shouldRepaint(covariant _AppRefreshAnimPaint oldDelegate) {
    return value != oldDelegate.value;
  }
}

enum _MoveDirection { up, down }

class AppRefreshAnimController {
  late VoidCallback? _onStopCallback;
  late VoidCallback? _onStartCallback;

  void stop() {
    _onStopCallback?.call();
  }

  void start() {
    _onStartCallback?.call();
  }
}
