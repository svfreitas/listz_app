import 'package:listz_app/data/models/item_model.dart';
import 'package:listz_app/data/models/listz_model.dart';

abstract class Repository {
  Future<List<ListZ>> getLists();
  Future<List<Item>> getListItems(String? listName);
  Future<String?> login(String? username, String? password);
}
