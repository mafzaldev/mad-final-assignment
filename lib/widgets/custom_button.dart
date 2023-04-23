// create a custom button widget using container

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color = Colors.teal,
    required this.text,
    required this.width,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 16))),
    );
  }
}
