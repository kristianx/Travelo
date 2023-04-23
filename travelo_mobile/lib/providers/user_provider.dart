import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../main.dart';
import '../model/user.dart';
import '../utils/util.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    // TODO: implement fromJson
    return User();
  }

  Future<bool> loginUser(String email, String password) async {
    if (checkLoginStatus()) {
      print("Logged in");
      return true;
    }

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
      // await storage.write(key: 'jwt', value: response!.body);
      // await storage.write(key: 'username', value: email);
      // await storage.write(key: 'password', value: password);
      localStorage.setItem('email', email);
      localStorage.setItem('password', password);

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
      // await storage.write(key: 'jwt', value: response!.body);
      // await storage.write(key: 'username', value: email);
      // await storage.write(key: 'password', value: password);
      // Authorization.email = email;
      // Authorization.password = password;
      localStorage.setItem('email', email);
      localStorage.setItem('password', password);
      return true;
    } else {
      print("Registration error here");
      return false;
    }
  }

  bool checkLoginStatus() {
    String? email = localStorage.getItem('email');
    String? password = localStorage.getItem('password');
    print("email: " + email.toString());
    print("password: " + password.toString());
    if (email != null && email != "" && password != null && password != "") {
      return true;
    }
    return false;
  }

  void logOut() {
    localStorage.setItem('email', null);
    localStorage.setItem('password', null);
  }
}
