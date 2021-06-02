import 'dart:developer';

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

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initializedMqtt() async {
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
    } catch (e) {
      log(e.toString());
      _client.disconnect();
    }
  }

  Future disConnect() async {
    try {
      _client.disconnect();
    } catch (e) {
      log('Diconnetion Failed');
    }
  }

  void _onConnected() {
    log('Connected');
  }

  void _onDisConnected() {
    log('Disconnected');
  }

  void _onSubscribed(String? topic) {
    log('topic = $topic');
  }

  void listenMqtt() {
    _client.subscribe(topic!, MqttQos.atLeastOnce);
    _client.updates!.listen((dynamic t) {
      MqttPublishMessage recMessage = t[0].payload;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMessage.payload.message!);
    });
  }

  void publishMqtt() {
    final builder = MqttClientPayloadBuilder();
    builder.addString('val');
    _client.publishMessage(topic!, MqttQos.atLeastOnce, builder.payload!);
    builder.clear();
  }
}
