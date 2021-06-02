import 'package:ake_elevator_similator/controllers/animation_check.dart';
import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/services/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/screen.dart';

void main() {
  Get.put(AnimationCheck());
  Get.put(ElevatorController());
  Get.put(MqttService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX MQTT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(title: 'Flutter GetX MQTT'),
    );
  }
}
