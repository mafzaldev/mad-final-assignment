import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.type = "FormField",
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  final String hintText;
  final String type;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return type == "FormField"
        ? TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: validator,
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
  }
}
