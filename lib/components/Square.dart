import 'package:flutter/material.dart';

class Squarefield extends StatelessWidget {
  final String imagepath;
  final VoidCallback onTap;
  const Squarefield({super.key, required this.imagepath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200]),
        child: Image.asset(
          imagepath,
          height: 40,
        ))
    );
  }
}
