import 'package:ake_elevator_similator/services/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';
import '../widgets/widget.dart';

class WelcomeScreen extends GetView<ElevatorController> {
  WelcomeScreen({
    Key? key,
    this.title,
  }) : super(key: key) {
    for (var i = 0; i < 3; i++) {
      _textController.add(TextEditingController());
    }
  }

  final String? title;

  final _textController = <TextEditingController>[];
  final _formKey = GlobalKey<FormState>();
  final _titles = <String>[
    'Host',
    'Port',
    'Topic',
  ];

  String? host;
  String? port;
  String? topic;

  void _connectionMqtt() {
    MqttService service = Get.find();
    if (_formKey.currentState!.validate()) {
      host = _textController[0].text;
      port = _textController[1].text;
      topic = _textController[2].text;
      service = MqttService(
        host: host,
        port: port,
        topic: topic,
      );
      service.initializedMqtt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title!),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputText(
                formKeys: _formKey,
                textControllers: _textController,
                titles: _titles,
              ),
              StatusCheck(
                title: "I'm publisher",
                onPressed: (check) => print(check),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _connectionMqtt(),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Icon(Icons.connect_without_contact_sharp),
        ),
      ),
    );
  }
}
