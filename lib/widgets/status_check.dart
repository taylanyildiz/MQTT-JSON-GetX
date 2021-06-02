import 'package:ake_elevator_similator/controllers/animation_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCheck extends GetView<AnimationCheck> {
  const StatusCheck({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function(bool) onPressed;

  final String title;

  void _onPressed() {
    AnimationCheck _anim = Get.find();
    if (_anim.status == AnimationStatus.completed) {
      _anim.reset();
      onPressed.call(false);
    } else {
      _anim.forward();
      onPressed.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () => _onPressed(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder(
              builder: (AnimationCheck _) => AnimatedBuilder(
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
    );
  }
}
