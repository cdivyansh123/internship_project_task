import 'package:expense_management_system/screens/dashboard_screen.dart';
import 'package:expense_management_system/screens/registration_screen.dart';
import 'package:expense_management_system/services/api_service.dart';
import 'package:expense_management_system/services/auth_service.dart';
import 'package:expense_management_system/widgets/custom_button.dart';
import 'package:expense_management_system/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../services/handle_ssl_certificate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  callLoginApi() {
    final service = ApiServices();
    service.apicalllogin(
      {
        "userNameOrEmailAddress": _emailController.text,
        "password": _passwordController.text,
        "rememberMe": true.toString(), // Cast boolean value to string
      },
    ).then((value) {
      if (value.error != null) {
        print(value.error);
        setState(() {
          errorMessage = "Invalid username or password";
          isLoading = false;
        });
      } else if (value.result == 1 && value.description == "Success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        setState(() {
          errorMessage = "Invalid username or password";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                    "Email",
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
                    text: "Login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        HttpService.setupHttpOverrides();
                        callLoginApi();
                        setState(() {
                          isLoading = true;
                          errorMessage = null;
                        });
                      }
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
                              builder: (context) => RegistrationScreen()));
                    },
                    child: Text(
                      "Not a member? Register Yourself!",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
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
