import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  CustomTextfield(
      {required this.hintText,
      required this.controller,
      this.validator,
      String? errorMessage});

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _errorMessage = widget.validator?.call(widget.controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.hintText.toLowerCase().contains("password"),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
