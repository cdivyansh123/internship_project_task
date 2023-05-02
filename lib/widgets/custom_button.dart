import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;

  CustomButton(
      {required this.text, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}
