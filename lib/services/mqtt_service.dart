import 'dart:convert';
import 'dart:developer';

import 'package:ake_elevator_similator/constants/mqtt_constant.dart';
import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/models/elevator_data.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// Connection Status Mqtt Class
enum MqttConnectionStatus {
  connecting,
  connected,
  disconnected,
  noChanged,
}

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

  /// Mqtt Connection Status
  late MqttConnectionStatus connectionStatus;

  /// MqttServer Client.
  late MqttServerClient _client;

  /// For list added.Listen and Send data.
  final ElevatorController _elevatorController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> initializedMqtt() async {
    _client = MqttServerClient(MqttConstant.MQTT_HOST_ADRESS, 'taylanyildz')
      ..logging(on: false)
      ..port = int.parse(MqttConstant.MQTT_PORT_ADRESS)
      ..keepAlivePeriod = 20
      ..autoReconnect = true
      ..onConnected = _onConnected
      ..onDisconnected = _onDisConnected
      ..onSubscribed = _onSubscribed
      ..pongCallback = getPong;

    final connMessage = MqttConnectMessage()
        // .authenticateAs(username, password)
        .withWillMessage('disconnected')
        .withWillTopic('publish')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    log('Connecting..');
    _client.connectionMessage = connMessage;
    try {
      await _client.connect(
        username,
        password,
      );
      return true;
    } catch (e) {
      log(e.toString());
      _client.disconnect();
      return false;
    }
  }

  Future<void> disConnect() async {
    try {
      _client.disconnect();
    } catch (e) {
      log(e.toString());
    }
  }

  void _onConnected() {
    log('Connected');
    listenMqtt();
    connectionStatus = MqttConnectionStatus.connected;
  }

  void _onDisConnected() {
    log('Disconnected');
    connectionStatus = MqttConnectionStatus.disconnected;
  }

  void _onSubscribed(String? topic) {
    log('topic = $topic');
  }

  void getPong() {
    print('pong');
  }

  void listenMqtt() {
    _client.subscribe(MqttConstant.MQTT_TOPIC_KEY + '+', MqttQos.atLeastOnce);
    _client.updates!.listen((dynamic t) {
      MqttPublishMessage recMessage = t[0].payload;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMessage.payload.message!);
      final messageId = recMessage.variableHeader!.messageIdentifier;
      print('message id : $messageId -- $message');
      _elevatorController.listenElevator(message, messageId);
    });
  }

  void publishMqtt(ElevatorData? elevatorData) {
    if (connectionStatus == MqttConnectionStatus.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(jsonEncode(elevatorData!.toJson()));
      _client.publishMessage(MqttConstant.MQTT_TOPIC_KEY + elevatorData.imei,
          MqttQos.atLeastOnce, builder.payload!);
      builder.clear();
    }
  }
}
