import 'dart:convert';

import 'package:listz_app/core/env.dart';
import 'package:http/http.dart' as http;
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/core/global.dart';
import 'package:listz_app/data/repositories/response_API.dart';

class ListzAPI {
  Future<Map<String, String>> _createHeaders() async {
    String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  Future<String> getRawLists() async {
    var url = '$SERVER_URL/restricted/listz';
    var headers = await _createHeaders();

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> getRawListItems(String listName) async {
    var url = '$SERVER_URL/restricted/listz/$listName/items';
    var headers = await _createHeaders();

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> login(String username, String password) async {
    var url = '$SERVER_URL/login';
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;

    var response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      dynamic b = json.decode(response.body);
      var token = b['token'];
      await storage.write(key: 'token', value: b['token']);
      return token;
    } else if (response.statusCode == 401) {
      return "";
    } else {
      throw ServerException();
    }
  }
}
