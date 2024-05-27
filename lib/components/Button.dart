import 'package:flutter/material.dart';

class Buttonfield extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? textColor;

  const Buttonfield({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
