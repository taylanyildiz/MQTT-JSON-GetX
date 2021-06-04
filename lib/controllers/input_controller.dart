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
    for (var i = 0; i < 3; i++) {
      textControllers.add(TextEditingController());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Form widget key.
  final GlobalKey<FormState> formKey = GlobalKey();

  /// TextFormField controller.
  final textControllers = <TextEditingController>[];

  /// Mqtt Host Adress
  late final String? host;

  /// Mqtt Port Adress
  late final String? port;

  /// Mqtt Topic Key
  late final String? topic;

  /// If you have username for Mqtt server.
  late final String? username;

  /// If you have password for Mqtt server.
  late final String? password;

  /// Your app is pusblisher default value [false]
  late bool isPublisher = false;

  /// If you have username and password.
  late bool isHaveUser = false;

  /// ElevatorController object.
  final ElevatorController _elevatorController = Get.find();

  void publisherSet(bool isPublisher) {
    this.isPublisher = isPublisher;
    update();
  }

  /// Added Form input.
  void addedInput() {
    /// Form check empty.
    if (formKey.currentState!.validate()) {
      host = textControllers[0].text;
      port = textControllers[1].text;
      topic = textControllers[2].text;
    } else {
      _elevatorController.initializedMqtt();

      /// If publisher
      if (!isPublisher)
        Get.to(() => SubscribeScreen());

      /// If subscriber.
      else
        Get.to(() => PublisScreen());
    }
  }
}
