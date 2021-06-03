import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AnimationListenerController extends GetxController
    with SingleGetTickerProviderMixin {
  ///
  late AnimationController _controller;

  /// Get animationController
  AnimationController get animationController => _controller;

  /// Run animation and reverse
  void runAnimation() async {
    _controller.forward();
    await Future.delayed(Duration(milliseconds: 200));
    _controller.reverse();
  }

  @override
  void onInit() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _controller.addListener(_onListener);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.removeListener(_onListener);
    super.onClose();
  }

  void _onListener() {
    update();
  }
}
