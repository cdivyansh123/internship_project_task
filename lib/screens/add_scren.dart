import 'package:expense_management_system/screens/view_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_management_system/widgets/custom_button.dart';
import 'package:expense_management_system/widgets/custom_textfield.dart';

import '../services/api_service.dart';
import '../services/handle_ssl_certificate.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required.';
    }
    return null;
  }

  String? _validateAbout(String? value) {
    if (value == null || value.isEmpty) {
      return 'About is required.';
    }
    return null;
  }

  void callcreategroup() async {
    final service = ApiServices();
    var response = await service.apicreategroup({
      "name": _nameController.text,
      "about": _aboutController.text,
      "groupMembers": [
        {
          "userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        }
      ]

    });

    if (response.statusCode == 200) {
      print("response=200");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create group"),
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
                    hintText: "Enter Group Name",
                    controller: _nameController,
                    validator: _validateName,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "About",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "Enter something about group",
                    controller: _aboutController,
                    validator: _validateAbout,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomButton(
                    text: "Create",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        HttpService.setupHttpOverrides();
                        callcreategroup();
                        //todo
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
