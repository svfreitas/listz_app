import 'package:listz_app/data/datasources/listzAPI.dart';
import 'package:listz_app/data/datasources/listzAPI_Fake.dart';
import 'package:listz_app/data/repositories/response_API.dart';
import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/models/listz_model.dart';
import 'package:listz_app/data/repositories/repository.dart';

class ListzRepository implements Repository {
  final ListzAPI listzAPI = ListzAPI();

  Future<List<ListZ>> getLists() async {
    String rawData = await listzAPI.getRawLists();
    var apiParsed = responseFromJson(rawData);
    return List<ListZ>.from(apiParsed.data.map((x) => ListZ.fromJson(x)));
  }

  Future<List<Item>> getListItems(String? listName) async {
    String rawData = await listzAPI.getRawListItems(listName);
    var apiParsed = responseFromJson(rawData);
    return List<Item>.from(apiParsed.data.map((x) => Item.fromJson(x)));
  }

  Future<String?> login(String? username, String? password) async {
    String? token = await listzAPI.login(username, password);
    return token;
  }

  Future<bool> signUp(String username, String password, String email) async {
    bool? result = await listzAPI.signUp(username, password, email);
    return result!;
  }

  Future<bool> createList(String? name, String? description) async {
    bool? result = await listzAPI.createList(name, description);
    return result!;
  }
}
