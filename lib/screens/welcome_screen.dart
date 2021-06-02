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
      _textController.add(TextEditingController());
    }
  }

  final String? title;

  final _textController = <TextEditingController>[];
  final _formKey = GlobalKey<FormState>();
  final _titles = <String>[
    'Host',
    'Port',
    'Topic',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title!),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputText(
                formKeys: _formKey,
                textControllers: _textController,
                titles: _titles,
              ),
              CheckUser(
                onPressed: (check) => print(check),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print(''),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Icon(Icons.connect_without_contact_sharp),
        ),
      ),
    );
  }
}
