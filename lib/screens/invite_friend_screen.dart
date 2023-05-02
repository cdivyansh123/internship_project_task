import 'package:expense_management_system/services/auth_service.dart';
import 'package:expense_management_system/widgets/custom_button.dart';
import 'package:expense_management_system/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/handle_ssl_certificate.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InvitecreenState();
}

class _InvitecreenState extends State<InviteScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String? errorMessage;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  void callInviteFriendApi() async {
    // String name = _nameController.text;
    // String emailId = _emailController.text;
    final service = ApiServices();
    var response = await service.apiCallInviteFriend(
        _nameController.text, _emailController.text);
    if (response.statusCode == 200) {
      print("successful invitation");
      // Handle successful response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
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
                    hintText: "Enter Name",
                    validator: Validator.nameValidator,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "Enter Email",
                    validator: Validator.emailValidator,
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomButton(
                    text: "Send Invitation",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        HttpService.setupHttpOverrides();
                        callInviteFriendApi();
                        //todo
                      }
                    },
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 12,
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
