import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AnimationCheck extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _controller;
  AnimationCheck() {
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _controller.addListener(_listenerAnimation);
  }

  void _listenerAnimation() {
    update();
  }

  void forward() => _controller.forward();

  void reset() => _controller.reset();

  AnimationStatus get status => _controller.status;

  @override
  void dispose() {
    _controller.removeListener(_listenerAnimation);
    super.dispose();
  }
}
