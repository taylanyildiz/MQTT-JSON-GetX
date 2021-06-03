import 'dart:developer';

import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService extends GetxService {
  MqttService({
    this.host,
    this.port,
    this.username,
    this.password,
    this.topic,
  });

  /// Server host adress.
  final String? host;

  /// Server port adress.
  final String? port;

  /// Server if have username.
  final String? username;

  /// Server if have password.
  final String? password;

  /// Every subscribe or publish have topic.
  final String? topic;

  late MqttServerClient _client;

  final ElevatorController _elevatorController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> initializedMqtt() async {
    _client = MqttServerClient(host!, 'taylanyildz')
      ..logging(on: false)
      ..port = int.parse(port!)
      ..keepAlivePeriod = 20
      ..onConnected = _onConnected
      ..onDisconnected = _onDisConnected
      ..onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        // .authenticateAs(username, password)
        .withWillMessage('willMessage')
        .withWillTopic('willTopic')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    log('Connecting..');
    _client.connectionMessage = connMessage;
    try {
      await _client.connect(username, password);
      return true;
    } catch (e) {
      log(e.toString());
      _client.disconnect();
      return false;
    }
  }

  Future disConnect() async {
    try {
      _client.disconnect();
    } catch (e) {
      log('Diconnection Failed');
    }
  }

  void _onConnected() {
    log('Connected');
    listenMqtt();
  }

  void _onDisConnected() {
    log('Disconnected');
  }

  void _onSubscribed(String? topic) {
    log('topic = $topic');
  }

  List<String> top = ["903461", "1084069", "314588"];

  void listenMqtt() {
    for (String t in top) {
      _client.subscribe(topic! + t, MqttQos.atLeastOnce);
      _client.updates!.listen((dynamic t) {
        MqttPublishMessage recMessage = t[0].payload;
        final message = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message!);
        _elevatorController.listenElevator(message);
        print(message);
      });
    }
  }

  void publishMqtt(String? message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message!);
    _client.publishMessage(topic!, MqttQos.atLeastOnce, builder.payload!);
    builder.clear();
  }
}
