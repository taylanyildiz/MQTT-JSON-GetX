import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/widgets/animated_list_publish.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublisScreen extends GetView<ElevatorController> {
  PublisScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added Elevator Data'),
        centerTitle: true,
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
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder(
        builder: (ElevatorController _) => ListView.builder(
          itemCount: controller.elevatorListPublish.length,
          itemBuilder: (context, index) => AnimatedListPublish(index: index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.createElevator(),
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
    );
  }
}
