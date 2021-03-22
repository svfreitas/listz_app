import 'package:listz_app/core/global.dart';

class ListzAPIFake {
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
    var headers = await _createHeaders();
    return '{"status":"ok","message":"", "data": []}';
  }

  Future<String> getRawListItems(String? listName) async {
    var headers = await _createHeaders();
    return '{"status":"ok","message":"", "data": []}';
  }

  Future<String?> login(String? username, String? password) async {
    await storage.write(key: 'token', value: 'FAKE_TOKEN');
    return 'FAKE_TOKEN';
  }
}
