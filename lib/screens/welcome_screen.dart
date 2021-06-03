import 'package:ake_elevator_similator/controllers/input_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';
import '../widgets/widget.dart';

class WelcomeScreen extends GetView<ElevatorController> {
  WelcomeScreen({
    Key? key,
    this.title,
  }) : super(key: key) {
    for (var i = 0; i < 3; i++) {
      _textControllers.add(TextEditingController());
    }
  }

  final String? title;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _textControllers = <TextEditingController>[];

  final InputController inputController = Get.find();

   bool isPublisher = false;

   bool isHaveUser = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(title!),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputText(
                formKeys: _formKey,
                textControllers: _textControllers,
              ),
              StatusCheck(
                title: "I'm publisher",
                onPressed: (check) => isPublisher = check,
              ),
              StatusCheck(
                title: "I have username-password",
                onPressed: (check) => isHaveUser = check,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.login),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            onPressed: () {
              inputController.addedInput(
                  _textControllers, _formKey, isPublisher, isHaveUser);
              FocusScope.of(context).unfocus();
            }),
      ),
    );
  }
}
