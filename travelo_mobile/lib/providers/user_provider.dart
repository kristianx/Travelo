import 'dart:convert';
import 'dart:io';
import '../main.dart';
import '../model/user.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    // TODO: implement fromJson

    return User.fromJson(data);
  }

  Future<bool> loginUser(String? email, String? password) async {
    if (email == null || password == null) {
      // throw Exception("Email or password is null");
      return false;
    }

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$email:$password:traveler'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    var response = await http?.post(Uri.parse("${baseUrl}User/Login"),
        body:
            jsonEncode(<String, String>{"email": email, "password": password}),
        headers: headers);
    if (response?.statusCode == 200 && response != null) {
      print("Login success");
      await localStorage.setItem('email', email);
      await localStorage.setItem('password', password);
      await localStorage.setItem('userId', int.parse(response.body));
      return true;
    } else {
      print("Login error here");
      return false;
    }
  }

  Future<User> uploadImage(int userId, File file) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(Uri.parse("${baseUrl}User/uploadImage"),
        body: jsonEncode(<String, dynamic>{
          "userId": userId,
          "image": base64Encode(file.readAsBytesSync())
        }),
        headers: headers);

    if (isValidResponseCode(response!)) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<bool> registerUser(String firstName, String lastName, String email,
      String password, String username, int CityId) async {
    var response = await http?.post(Uri.parse("${baseUrl}User/Register"),
        body: jsonEncode(<String, dynamic>{
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
      // await localStorage.setItem('email', email);
      // await localStorage.setItem('password', password);
      // return true;
      return loginUser(email, password);
    } else {
      print("Registration error here");
      return false;
    }
  }

  // bool checkLoginStatus() {
  //   String? email = localStorage.getItem('email');
  //   String? password = localStorage.getItem('password');
  //   if (email != null && email != "" && password != null && password != "") {
  //     return true;
  //   }
  //   return false;
  // }

  void newAuth() {
    localStorage.deleteItem("email");
    localStorage.deleteItem("password");
  }

  void logOut() async {
    await localStorage.setItem('email', null);
    await localStorage.setItem('password', null);
  }
}
