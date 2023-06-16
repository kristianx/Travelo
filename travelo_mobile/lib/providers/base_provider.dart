import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String? _endpoint;

  HttpClient client = HttpClient();
  IOClient? http;

  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://127.0.0.1:7100/");
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }

    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  // Future<List<T>> getById(int id, [dynamic additionalData]) async {
  //   var url = Uri.parse("$_baseUrl$_endpoint/$id");

  //   Map<String, String> headers = await createHeaders();

  //   var response = await http!.get(url, headers: headers);

  //   if (isValidResponseCode(response)) {
  //     var data = jsonDecode(response.body);
  //     return data.map((x) => fromJson(x)).cast<T>().toList();
  //   } else {
  //     throw Exception("Exception... handle this gracefully");
  //   }
  // }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");

    Map<String, String> headers = await createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      // var data = jsonDecode(response.body);
      // Future<T>.from(); fromJson(data);

      return fromJson(jsonDecode(response.body));
      // return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> get([dynamic search]) async {
    var url = "$_baseUrl$_endpoint";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    print("get me");
    var response = await http!.get(uri, headers: headers);
    print("done $response");
    if (isValidResponseCode(response)) {
      print("good");
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      print("not good");
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<Map<String, String>> createHeaders() async {
    // String? jwt = await storage.read(key: "jwt");

    // String? username = Authorization.email;
    // String? password = Authorization.password;

    // String? username = await storage.read(key: 'username');
    // String? password = await storage.read(key: 'password');

    String? email = localStorage.getItem('email');
    String? password = localStorage.getItem('password');
    // String? username = await storage.read(key: 'username');
    // String? password = await storage.read(key: 'password');

    // print("Auth: " + username.toString() + " " + password.toString());

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$email:$password:traveler'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
      // "Authorization": "Bearer $jwt",
    };
    return headers;
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
