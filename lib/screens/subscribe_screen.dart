import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenScreen extends GetView<ElevatorController> {
  ListenScreen({
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
        builder: (ElevatorController _) {
          return ListView.builder(
            itemCount: controller.elevatorList.length,
            itemBuilder: (context, index) => AnimatedListListener(index: index),
          );
        },
      ),
    );
  }
}
