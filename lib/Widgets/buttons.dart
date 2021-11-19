import 'dart:ui';

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.color, required this.onPressed, required this.title}) : super(key: key);

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
