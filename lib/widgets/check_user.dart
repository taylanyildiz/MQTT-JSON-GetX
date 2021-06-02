import 'package:ake_elevator_similator/controllers/animation_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUser extends GetView<AnimationCheck> {
  const CheckUser({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function(bool) onPressed;

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
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder(
            builder: (AnimationCheck _) => GestureDetector(
              onTap: () => _onPressed(),
              child: AnimatedBuilder(
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
          ),
          SizedBox(width: 5.0),
          Text(
            'Have Username Password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
