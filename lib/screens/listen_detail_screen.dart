import 'package:ake_elevator_similator/controllers/elevator_controller.dart';
import 'package:ake_elevator_similator/widgets/animated_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenDetailScreen extends GetView<ElevatorController> {
  const ListenDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  /// Which Elevator calling for detail.
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.elevatorListSubscribe[index].id}'),
        centerTitle: true,
      ),
      body: GetBuilder(
        builder: (ElevatorController _) => Stack(
          children: [
            AnimatedListDetail(index: index),
          ],
        ),
      ),
    );
  }
}
