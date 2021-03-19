import 'dart:convert';

List<Item> itemsFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemsToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    this.id,
    this.value,
    this.expireDate,
  });

  int? id;
  String? value;
  DateTime? expireDate;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        value: json["value"],
        expireDate: DateTime.parse(json["expire_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "expire_date": expireDate!.toIso8601String(),
      };
}
