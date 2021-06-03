import 'dart:convert';
import 'dart:math';

import 'package:ake_elevator_similator/models/model.dart';
import 'package:ake_elevator_similator/services/mqtt_service.dart';
import 'package:get/get.dart';

class ElevatorController extends GetxController {
  /// Get all elevator information.
  final elevatorList = <ElevatorData>[];

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
  Future<bool> initializedMqtt(MqttService service) async {
    return await service.initializedMqtt();
  }

  /// For publish elevator create.
  void createElevator() {
    ElevatorData randomElevator = getRandomElevator();
    elevatorList.add(randomElevator);
    update();
  }

  /// For publish elevetor send [publish]
  void sendElevatorInformation(int index) {
    /// Getx call [MqttService]
    final MqttService _mqttService = Get.find();
    while (true) {}
  }

  /// For subscribe listen server.
  void listenElevator(String? message) {
    ElevatorData elevatorData = ElevatorData.fromJson(jsonDecode(message!));
    int index =
        elevatorList.indexWhere((element) => element.id == elevatorData.id);
    if (index == -1) {
      elevatorList.add(elevatorData);
      update();
    } else {
      elevatorList[index] = elevatorData;
      update([index]);
    }
  }

  /// Disconnection MQTT
  void disconnectionMqtt() {
    /// Getx call [MqttService]
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
      isMove: isMove,
      maintenance: maintenance,
      status: status,
      dateTime: DateTime.now(),
    );
  }
}
