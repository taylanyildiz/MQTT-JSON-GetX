import 'package:ake_elevator_similator/controllers/animation_listener_controller.dart';
import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:ake_elevator_similator/screens/listen_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AnimatedListListener extends GetWidget<AnimationListenerController> {
  AnimatedListListener({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: index,
      builder: (ElevatorController _) {
        controller.runAnimation();
        return GestureDetector(
          onTap: () => Get.to(() => ListenDetailScreen(index: index)),
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) => Opacity(
              opacity: Tween<double>(begin: 1.0, end: 0.0)
                  .animate(controller.animationController)
                  .value,
              child: child!,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${_.elevatorList[index].id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text('${_.elevatorList[index].status}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
