import 'package:ake_elevator_similator/controllers/elevator_controller.dart';
import 'package:ake_elevator_similator/widgets/animated_list_detail.dart';
import 'package:ake_elevator_similator/widgets/elevator_console.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenDetailScreen extends StatelessWidget {
  const ListenDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  /// Which Elevator calling for detail.
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (ElevatorController _) => Scaffold(
        appBar: AppBar(
          title: Text('${_.elevatorListSubscribe[index].id}'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            AnimatedListDetail(index: index),
            ElevatorConsole(),
          ],
        ),
      ),
    );
  }
}
