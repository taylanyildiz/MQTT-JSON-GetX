import 'dart:convert';
import 'dart:math';
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

  /// Current floor.
  late int currentFloor = 3;

  /// Calling floor.
  late int callingFloor = 3;

  @override
  void onInit() {
    super.onInit();
    random = Random();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Connection Mqtt Server
  Future<bool> initializedMqtt() {
    MqttService _mqttService = Get.find();
    return _mqttService.initializedMqtt();
  }

  /// For publish elevator create.
  void createElevator() {
    ElevatorData randomElevator = getRandomElevator();
    topics.add(randomElevator.id);
    elevatorListPublish.add(randomElevator);
    sendElevatorData(elevatorListPublish.length - 1);
    update(topics);
  }

  void sendElevatorData(int index) async {
    final MqttService _mqttService = Get.find();

    while (_mqttService.connectionStatus == MqttConnectionStatus.connected) {
      elevatorListPublish[index] = getRandomElevator(
          imei: elevatorListPublish[index].imei, floor: callingFloor);
      _mqttService.publishMqtt(elevatorListPublish[index]);
      update();
      await Future.delayed(Duration(seconds: 5));
    }
  }

  /// For subscribe listen server.
  void listenElevator(String? message, int? messageId) async {
    ElevatorData elevatorData = ElevatorData.fromJson(jsonDecode(message!));
    callingFloor = elevatorData.floor;
    int index = elevatorListSubscribe
        .indexWhere((element) => element.id == elevatorData.id);
    if (index == -1) {
      elevatorListSubscribe.add(elevatorData);
      update();
      await Future.delayed(Duration(seconds: 5));
    } else {
      elevatorListSubscribe[index] = elevatorData;
      update([index]);
      await Future.delayed(Duration(seconds: 5));
    }
  }

  /// Disconnection MQTT
  void disconnectionMqtt() async {
    /// MqttService Object from GetX.
    final MqttService _mqttService = Get.find();
    await _mqttService.disConnect();
    elevatorListPublish.clear();
  }

  ElevatorData getRandomElevator({
    String? imei,
    String? id,
    int? floor,
    bool? isMove,
    bool? maintenance,
    bool? status,
  }) {
    return ElevatorData(
      id: id ?? '0',
      imei: imei ?? (random!.nextInt(99999) + 10000).toString(),
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
