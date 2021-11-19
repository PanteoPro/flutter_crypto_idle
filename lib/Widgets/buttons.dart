import 'dart:ui';

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.title,
    this.textColor,
  }) : super(key: key);

  final Color color;
  final Color? textColor;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(textColor ?? Colors.white),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
