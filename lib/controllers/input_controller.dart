import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/screens/publish_screen.dart';
import 'package:ake_elevator_similator/screens/subscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class InputController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  late final String? host;
  late final String? port;
  late final String? topic;
  late final String? username;
  late final String? password;
  late final bool? isPublisher;
  late final bool? isHaveUser;

  final ElevatorController _elevatorController = Get.find();

  /// Added Form input.
  void addedInput(List<TextEditingController> controller,
      GlobalKey<FormState> formKey, bool isPublisher, bool isHaveUser) {
    /// Form check empty.
    if (formKey.currentState!.validate()) {
      host = controller[0].text;
      port = controller[1].text;
      topic = controller[2].text;
    } else {
      _elevatorController.initializedMqtt();
      if (!isPublisher)
        Get.to(() => SubscribeScreen());
      else
        Get.to(() => PublisScreen());
    }
  }
}
