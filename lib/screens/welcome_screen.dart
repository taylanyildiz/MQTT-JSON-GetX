import 'package:ake_elevator_similator/controllers/input_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';
import '../widgets/widget.dart';

class WelcomeScreen extends GetView<ElevatorController> {
  WelcomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  /// Input labels.
  final String? title;

  /// InputController class object.
  final InputController inputController = Get.find();

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
                formKeys: inputController.formKey,
                textControllers: inputController.textControllers,
              ),
              StatusCheck(
                title: "I'm publisher",
                onPressed: (check) => inputController.publisherSet(check),
              ),
              StatusCheck(
                title: "I have username-password",
                onPressed: (check) => print(check),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.login),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: () {
            inputController.addedInput();
          },
        ),
      ),
    );
  }
}
