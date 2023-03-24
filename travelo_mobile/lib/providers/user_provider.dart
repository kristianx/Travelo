import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';
import 'base_provider.dart';
import 'package:http/http.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");
  final storage = FlutterSecureStorage();
  @override
  User fromJson(data) {
    // TODO: implement fromJson
    return User();
  }

  Future<bool> loginUser(String email, String password) async {
    var response = await http?.post(
        Uri.parse("https://127.0.0.1:7100/User/Login"),
        body:
            jsonEncode(<String, String>{"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (response?.statusCode == 200) {
      // var loginArr = response!.body;
      // print("Jwt:" + loginArr);
      print("Login success");
      await storage.write(key: 'jwt', value: response!.body);
      return true;
    } else {
      print("Login error here");
      return false;
    }
  }

  Future<bool> registerUser(String firstName, String lastName, String email,
      String password, String username, String CityId) async {
    var response =
        await http?.post(Uri.parse("https://127.0.0.1:7100/User/Register"),
            body: jsonEncode(<String, String>{
              "firstName": firstName,
              "lastName": lastName,
              "email": email,
              "password": password,
              "confirmPassword": password,
              "username": username,
              "CityId": CityId,
            }),
            headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response?.statusCode == 200) {
      print("Registration success");
      await storage.write(key: 'jwt', value: response!.body);
      return true;
    } else {
      print("Registration error here");
      return false;
    }
  }
}
