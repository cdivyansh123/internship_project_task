import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class UserDataInputScreen extends StatefulWidget {
  @override
  _UserDataInputScreenState createState() => _UserDataInputScreenState();
}

class _UserDataInputScreenState extends State<UserDataInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _suiteController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _catchPhraseController = TextEditingController();
  final TextEditingController _bsController = TextEditingController();

  Future<String> createUser() async {
    var response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "name": _nameController.text,
        "username": _usernameController.text,
        "email": _emailController.text,
        "address": {
          "street": _streetController.text,
          "suite": _suiteController.text,
          "city": _cityController.text,
          "zipcode": _zipcodeController.text,
          "geo": {
            "lat": _latController.text,
            "lng": _lngController.text,
          }
        },
        "phone": _phoneController.text,
        "website": _websiteController.text,
        "company": {
          "name": _companyNameController.text,
          "catchPhrase": _catchPhraseController.text,
          "bs": _bsController.text
        }
      }),
    );
    if (response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['id'].toString();
    } else {
      return 'Error';
    }
  }
  void _submitForm() async {
    String response = await createUser();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResponseScreen(
          userData: {
            'name': _nameController.text,
            'username': _usernameController.text,
            'email': _emailController.text,
            'address': {
              'street': _streetController.text,
              'suite': _suiteController.text,
              'city': _cityController.text,
              'zipcode': _zipcodeController.text,
              'geo': {
                'lat': _latController.text,
                'lng': _lngController.text,
              }
            },
            'phone': _phoneController.text,
            'website': _websiteController.text,
            'company': {
              'name': _companyNameController.text,
              'catchPhrase': _catchPhraseController.text,
              'bs': _bsController.text,
            },
          },
          response: response,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Input'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _suiteController,
                decoration: InputDecoration(
                  labelText: 'Suite',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _zipcodeController,
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _latController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _lngController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _websiteController,
                decoration: InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _catchPhraseController,
                decoration: InputDecoration(
                  labelText: 'Catch Phrase',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _bsController,
                decoration: InputDecoration(
                  labelText: 'BS',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponseScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String response;

  const ResponseScreen({
    Key? key,
    required this.userData,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Response'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User created with id: $response'),
            SizedBox(height: 16),
            Text('Name: ${userData['name']}'),
            Text('Username: ${userData['username']}'),
            Text('Email: ${userData['email']}'),
            Text('Address:'),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Street: ${userData['address']['street']}'),
                  Text('Suite: ${userData['address']['suite']}'),
                  Text('City: ${userData['address']['city']}'),
                  Text('Zipcode: ${userData['address']['zipcode']}'),
                  Text('Geo:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lat: ${userData['address']['geo']['lat']}'),
                        Text('Lng: ${userData['address']['geo']['lng']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('Phone: ${userData['phone']}'),
            Text('Website: ${userData['website']}'),
            Text('Company:'),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${userData['company']['name']}'),
                  Text('Catch Phrase: ${userData['company']['catchPhrase']}'),
                  Text('BS: ${userData['company']['bs']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
