import 'dart:convert';

import 'package:listz_app/core/env.dart';
import 'package:http/http.dart' as http;
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/core/global.dart';

class ListzAPI {
  Future<Map<String, String>> _createHeaders() async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  Future<String> getRawLists() async {
    var uri = Uri.http(ServerAddress, '/restricted/listz');
    var headers = await _createHeaders();

    //final response = await http.get(Uri(scheme: url), headers: headers);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> getRawListItems(String? listName) async {
    var uri = Uri.http(ServerAddress, '/restricted/listz/$listName/items');
    var headers = await _createHeaders();

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String?> login(String? username, String? password) async {
    var uri = Uri.http(ServerAddress, '/login');

    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;

    var response = await http.post(uri, body: map);
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

  Future<bool?> signUp(
      String? username, String? password, String? email) async {
//TODO create user
    var uri = Uri.http(ServerAddress, '/listz/_users');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    //  map['profile'] = "0";

    final response =
        await http.post(uri, body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
