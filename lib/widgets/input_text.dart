import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  InputText({
    Key? key,
    required this.formKeys,
    required this.textControllers,
    required this.titles,
  }) : super(key: key);

  final List<String> titles;

  final List<TextEditingController> textControllers;

  final GlobalKey<FormState> formKeys;

  @override
  Widget build(BuildContext context) {
    final content = titles
        .asMap()
        .map(
          (i, title) => MapEntry(
            i,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextFormField(
                validator: (input) => input!.isEmpty ? 'Can not be null' : null,
                controller: textControllers[i],
                autofocus: true,
                decoration: InputDecoration(
                  labelText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(
                    (() {
                      if (i == 0) return Icons.connect_without_contact;
                      if (i == 1) return Icons.connect_without_contact;
                      if (i == 2) return Icons.vpn_key;
                    }()),
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 10.0),
      child: Form(
        key: formKeys,
        child: Column(
          children: content,
        ),
      ),
    );
  }
}
