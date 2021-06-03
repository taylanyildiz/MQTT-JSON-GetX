import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AnimationCheck extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _controller;

  @override
  void onInit() {
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _controller.addListener(_listenerAnimation);
    super.onInit();
  }

  void _listenerAnimation() {
    update();
  }

  void forward() => _controller.forward();

  void reset() => _controller.reset();

  AnimationStatus get status => _controller.status;

  AnimationController get animationConroller => _controller;

  @override
  void onClose() {
    _controller.removeListener(_listenerAnimation);
    super.onClose();
  }
}
