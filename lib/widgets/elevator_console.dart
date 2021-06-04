import 'package:ake_elevator_similator/controllers/console_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElevatorConsole extends GetWidget<ConsoleAnimationController> {
  const ElevatorConsole({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (ConsoleAnimationController _) {
        return AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            final top = Get.height /
                (6.2 * (controller.value > 0.2 ? controller.value * .3 : .2));
            return Positioned(
              top: top,
              child: child!,
            );
          },
          child: GestureDetector(
            onVerticalDragEnd: controller.handleDragEnd,
            onVerticalDragUpdate: controller.handleDragUpdate,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              height: Get.height / 3,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                ),
              ),
              child: Center(
                child: Wrap(
                  runSpacing: 15,
                  spacing: 60,
                  children: List.generate(
                    10,
                    (index) => InkWell(
                      onTap: () => print(index),
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$index',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
