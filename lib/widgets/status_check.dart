import 'package:ake_elevator_similator/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCheck extends GetWidget<AnimationCheck> {
  const StatusCheck({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function(bool) onPressed;

  final String title;

  void _onPressed(AnimationCheck anim) {
    if (anim.status == AnimationStatus.completed) {
      anim.reset();
      onPressed.call(false);
    } else {
      anim.forward();
      onPressed.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GetBuilder(
        builder: (AnimationCheck _) => GestureDetector(
          onTap: () => _onPressed(controller),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.status != AnimationStatus.completed
                          ? Colors.white
                          : Colors.green,
                      border: Border.all(
                        color: controller.status != AnimationStatus.completed
                            ? Colors.black
                            : Colors.green,
                        width: 1.0,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  );
                },
              ),
              SizedBox(width: 5.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
