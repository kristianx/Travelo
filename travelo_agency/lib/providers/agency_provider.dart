import 'dart:convert';
import 'dart:io';
import '../main.dart';

import '../models/agency.dart';
import 'base_provider.dart';

class AgencyProvider extends BaseProvider<Agency> {
  AgencyProvider() : super("Agency");

  @override
  Agency fromJson(data) {
    return Agency.fromJson(data);
  }

  Future<bool> login(String? email, String? password) async {
    if (email == null || password == null) {
      // throw Exception("Email or password is null");
      return false;
    }
    Map<String, String> headers = await createHeaders();
    var response = await http?.post(
        Uri.parse("https://127.0.0.1:7100/Agency/Login"),
        body:
            jsonEncode(<String, String>{"email": email, "password": password}),
        headers: headers);
    if (response?.statusCode == 200 && response != null) {
      print("Login success");
      localStorage.setItem('email', email);
      localStorage.setItem('password', password);
      localStorage.setItem('agencyId', int.parse(response.body));
      return true;
    } else {
      print("Login error here");
      return false;
    }
  }

  Future<bool> uploadImage(int userId, File file) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(
        Uri.parse("https://127.0.0.1:7100/Agency/UpdateImage"),
        body: jsonEncode(<String, dynamic>{
          "agencyId": userId,
          "image": base64Encode(file.readAsBytesSync())
        }),
        headers: headers);

    if (response!.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String phone,
    String websiteUrl,
    String about,
    String address,
    String postalCode,
    String password,
    String confirmPassword,
    int cityId,
  ) async {
    var response = await http?.post(Uri.parse("https://127.0.0.1:7100/Agency"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "email": email,
          "phone": phone,
          "websiteUrl": websiteUrl,
          "about": about,
          "address": address,
          "postalCode": postalCode,
          "password": password,
          "confirmPassword": confirmPassword,
          "cityId": cityId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response?.statusCode == 200) {
      print("Registration success");
      localStorage.setItem('email', email);
      localStorage.setItem('password', password);
      localStorage.setItem('agencyId', fromJson(jsonDecode(response!.body)).id);
      return true;
    } else {
      print("Registration error here");
      return false;
    }
  }

  void newAuth(String email, String password) {
    localStorage.setItem('email', email);
    localStorage.setItem('password', password);
  }

  void logOut() {
    localStorage.setItem('email', null);
    localStorage.setItem('password', null);
  }
}
