import 'package:flutter/material.dart';

class TextFieldlogin extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final TextStyle? labelStyle;

  const TextFieldlogin({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
