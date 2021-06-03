import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeScreen extends GetView<ElevatorController> {
  SubscribeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('Listen Screen'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton.icon(
            onPressed: () {
              controller.disconnectionMqtt();
              Get.back();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(
              'Logot',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder(
        init: ElevatorController(),
        builder: (ElevatorController _) {
          return ListView.builder(
            itemCount: controller.elevatorListSubscribe.length,
            itemBuilder: (context, index) => AnimatedListListener(index: index),
          );
        },
      ),
    );
  }
}
