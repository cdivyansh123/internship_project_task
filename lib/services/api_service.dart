import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginApiResponse {
  final String? token;
  final String? error;
  final int? result;
  final String? description;

  LoginApiResponse({
    this.token,
    this.error,
    this.result,
    this.description,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) {
    return LoginApiResponse(
      token: json['token'],
      error: json['error'],
      result: json['result'],
      description: json['description'],
    );
  }
}

class ApiResponse {
  final String? error;
  final dynamic result;
  final int statusCode;

  ApiResponse({this.error, this.result, required this.statusCode});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      error: json['error'] != null ? jsonEncode(json['error']) : null,
      result: json['result'] != null ? jsonEncode(json['result']) : null,
      statusCode: json['statusCode'],
    );
  }
}

class ApiServices {
  Future<ApiResponse> apicreategroup(Map<String, dynamic> param) async {
    var url = Uri.parse("https://localhost:44329/api/app/group");
    var response = await http.post(
      url,
      body: jsonEncode(param),
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    print(response.body);
    final data = jsonDecode(response.body);
    return ApiResponse.fromJson({
      ...data,
      'statusCode': response.statusCode,
    });
  }

  Future<LoginApiResponse> apicalllogin(Map<String, dynamic> param) async {
    var url = Uri.parse("https://localhost:44329/api/account/login");
    var response = await http.post(
      url,
      body: jsonEncode(param),
      headers: {"Content-Type": "application/json"},
    );
    // print(response.body);
    final data = jsonDecode(response.body);
    return LoginApiResponse.fromJson(data);
  }

  Future<ApiResponse> apicallregister(Map<String, dynamic> param) async {
    var url = Uri.parse("https://localhost:44329/api/account/register");
    var response = await http.post(
      url,
      body: jsonEncode(param),
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    print(response.body);
    final data = jsonDecode(response.body);
    return ApiResponse.fromJson({
      ...data,
      'statusCode': response.statusCode,
    });
  }

  Future<ApiResponse> apiCallInviteFriend(String name, String emailId) async {
    debugPrint(emailId);
    debugPrint(name);
    try {
      var url = Uri.parse(
          "https://localhost:44329/api/app/add-friend/friend/$emailId?name=$name");
      // var url = Uri.parse(
      //     "https://localhost:44329/api/app/add-friend/friend/'${emailId}''?name=$name'");
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse.fromJson({
          ...data,
          'statusCode': response.statusCode,
        });
      } else {
        return ApiResponse(
          error: "API returned status code ${response.statusCode}",
          result: null,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      print("Error calling API: $e");
      return ApiResponse(
        error: "Error calling API: $e",
        result: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse> apiCallGroupList(String userId) async {
    try {
      var url = Uri.parse(
          "https://localhost:44329/api/app/group/groups-belonging-to-user/$userId");
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse.fromJson({
          ...data,
          'statusCode': response.statusCode,
        });
      } else {
        return ApiResponse.fromJson({
          'result': jsonDecode(response.body),
          'statusCode': response.statusCode,
        });
      }
    } catch (e) {
      print("Error calling API: $e");
      return ApiResponse(
        error: "Error calling API: $e",
        result: null,
        statusCode: 500,
      );
    }
  }
}
