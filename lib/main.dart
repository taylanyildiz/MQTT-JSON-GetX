import 'package:ake_elevator_similator/controllers/animation_listener_controller.dart';
import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/controllers/input_controller.dart';
import 'package:ake_elevator_similator/services/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/screen.dart';

void main() {
  Get.put(ElevatorController());
  Get.put(MqttService());
  Get.create(() => AnimationCheck());
  Get.create(() => AnimationListenerController());
  Get.put(InputController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX MQTT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(title: 'Flutter GetX MQTT'),
    );
  }
}
