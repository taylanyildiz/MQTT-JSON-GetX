import 'dart:convert';
import 'dart:math';

import 'package:ake_elevator_similator/constants/mqtt_constant.dart';
import 'package:ake_elevator_similator/models/model.dart';
import 'package:ake_elevator_similator/services/mqtt_service.dart';
import 'package:get/get.dart';

class ElevatorController extends GetxController {
  /// Get all elevator information. From Subscribe.
  final elevatorListSubscribe = <ElevatorData>[];

  /// Get all elevator information. From Publish.
  final elevatorListPublish = <ElevatorData>[];

  /// All topics [elevator]/[id]
  final topics = <String>[];

  /// Create random information data.
  late Random? random;

  @override
  void onInit() {
    super.onInit();
    random = Random();
  }

  /// Connection Mqtt Server
  Future<bool> initializedMqtt() async {
    MqttService _mqttService = Get.find();

    return _mqttService.initializedMqtt();
  }

  /// For publish elevator create.
  void createElevator() {
    ElevatorData randomElevator = getRandomElevator();
    topics.add(randomElevator.id);
    elevatorListPublish.add(randomElevator);
    final MqttService _mqttService = Get.find();
    _mqttService.publishMqtt(randomElevator);
    update();
  }

  /// For subscribe listen server.
  void listenElevator(String? message) {
    ElevatorData elevatorData = ElevatorData.fromJson(jsonDecode(message!));
    int index = elevatorListSubscribe
        .indexWhere((element) => element.id == elevatorData.id);
    if (index == -1) {
      elevatorListSubscribe.add(elevatorData);
      update();
    } else {
      elevatorListSubscribe[index] = elevatorData;
      update([index]);
    }
  }

  /// Disconnection MQTT
  void disconnectionMqtt() {
    /// MqttService Object from GetX.
    final MqttService _mqttService = Get.find();
    _mqttService.disConnect();
  }

  void callFloor(int? floor, String? id) {}

  ElevatorData getRandomElevator({
    String? imei,
    int? floor,
    bool? isMove,
    bool? maintenance,
    bool? status,
  }) {
    return ElevatorData(
      id: imei ?? (random!.nextInt(99999) + 10000).toString(),
      speed: random!.nextDouble() + random!.nextInt(255) + 100,
      temperature: random!.nextDouble() + random!.nextInt(255) + 100,
      floor: floor ?? 0,
      isMove: isMove ?? false,
      maintenance: maintenance ?? true,
      status: status ?? true,
      dateTime: DateTime.now().toString(),
    );
  }
}
