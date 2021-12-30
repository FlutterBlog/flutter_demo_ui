/*
 * flutter_ui_demo
 * splash_hide_factory.dart
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/material.dart';

// 水纹隐藏
class SplashHideFactory extends InteractiveInkFeatureFactory {
  @override
  InteractiveInkFeature create(
      {required MaterialInkController controller,
      required RenderBox referenceBox,
      required Offset position,
      required Color color,
      required TextDirection textDirection,
      bool containedInkWell = false,
      RectCallback? rectCallback,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      double? radius,
      VoidCallback? onRemoved}) {
    return InteractiveInkNoneFeature(
        controller: controller, referenceBox: referenceBox, color: color);
  }
}

// InteractiveInkFeature 空类
class InteractiveInkNoneFeature extends InteractiveInkFeature {
  InteractiveInkNoneFeature({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Color color,
  }) : super(controller: controller, referenceBox: referenceBox, color: color);

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
