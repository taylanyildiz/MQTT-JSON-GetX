import 'package:ake_elevator_similator/constants/mqtt_constant.dart';
import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/screens/subscribe_screen.dart';
import 'package:ake_elevator_similator/services/mqtt_service.dart';
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

  late MqttService service = Get.find();

  final ElevatorController _elevatorController = Get.find();

  void addedInput(List<TextEditingController> controller,
      GlobalKey<FormState> formKey) async {
    /// Form check empty.
    if (formKey.currentState!.validate()) {
      host = controller[0].text;
      port = controller[1].text;
      topic = controller[2].text;

      /// Don't have username and password
      service = MqttService(
        host: host,
        port: port,
        topic: topic,
      );

      /// Connection Check.
      bool isConnection = await _elevatorController.initializedMqtt(service);

      /// If Connected
      if (isConnection) {
        Get.to(() => ListenScreen());
      }

      /// If Connected failed.
      else {}
    } else {
      service = MqttService(
        host: MqttConstant.MQTT_HOST_ADRESS,
        port: MqttConstant.MQTT_PORT_ADRESS,
        topic: MqttConstant.MQTT_TOPIC_KEY,
      );
      await _elevatorController.initializedMqtt(service);
      Get.to(() => ListenScreen());
    }
  }
}
