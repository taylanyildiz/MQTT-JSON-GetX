import 'package:ake_elevator_similator/controllers/animation_listener_controller.dart';
import 'package:ake_elevator_similator/controllers/elevator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenDetailScreen extends GetView<AnimationListenerController> {
  const ListenDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  /// Which Elevator calling for detail.
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: index,
      builder: (ElevatorController _) {
        return AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            controller.runAnimation();
            return Opacity(
              opacity: Tween<double>(begin: 1.0, end: 0.0)
                  .animate(controller.animationController)
                  .value,
              child: child!,
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('${_.elevatorList[index].id}'),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      color: Colors.red,
                      child: Text('${_.elevatorList[index].status}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}