import 'package:expense_management_system/screens/dashboard_screen.dart';
import 'package:expense_management_system/screens/login_screen.dart';
import 'package:expense_management_system/screens/view_group_screen.dart';
import 'package:expense_management_system/widgets/custom_button.dart';
import 'package:expense_management_system/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/handle_ssl_certificate.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void callRegistrationApi() async {
    final service = ApiServices();
    var response = await service.apicallregister({
      "userName": _nameController.text,
      "emailAddress": _emailController.text,
      "password": _passwordController.text,
      "appName": "Expense Management System",
    });

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => ViewGroup()));
    } else if (response.statusCode == 403) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'User already exists',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "Enter your name",
                    validator: Validator.nameValidator,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Email Address",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "Enter your email",
                    validator: Validator.emailValidator,
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "Enter your password",
                    validator: Validator.passwordValidator,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomButton(
                    text: "Submit",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        HttpService.setupHttpOverrides();
                        callRegistrationApi();
                        setState(() {
                          isLoading = true;
                          errorMessage = null;
                        });
                      }
                      //todo
                    },
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Already a member? Login!",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
