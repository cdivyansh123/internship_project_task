import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  const MyButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed as void Function()?,
      icon: Icon(icon),
      label: Text(label,style: TextStyle(fontSize: 18),),
    );
  }
}
