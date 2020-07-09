import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final color;
  final textColor;
  final onTap;

  MyButton({this.buttonText, this.color, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap),
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 20 ,color: textColor),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
