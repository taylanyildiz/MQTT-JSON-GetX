import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsoleAnimationController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _controller;

  AnimationController get animationController => _controller;

  double get value => _controller.value;

  void handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / (Get.height / 3);
    update();
  }

  void handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) {
      update();
      return;
    }
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / (Get.height / 3);
    if (flingVelocity < 0.0)
      _controller.fling(velocity: max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    update();
  }

  @override
  void onInit() {
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addListener(_animationListener);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.removeListener(_animationListener);
    super.onClose();
  }

  void _animationListener() {
    update();
  }
}
