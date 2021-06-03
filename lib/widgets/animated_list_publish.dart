import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedListPublish extends GetWidget<AnimationListenerController> {
  AnimatedListPublish({
    Key? key,
    required this.index,
  }) : super(key: key);

  /// Every ElevetorController List have index.
  final int index;
  
  /// ElevatorController. 
  final ElevatorController _controller = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: [_controller.topics],
      builder: (ElevatorController _) {
        controller.createAnimation();
        return AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Opacity(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
                  .animate(controller.animationController)
                  .value,
              child: child!,
            );
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                  '${_.elevatorListPublish[index].id}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  children: [
                    Text('${_.elevatorListPublish[index].status}'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
