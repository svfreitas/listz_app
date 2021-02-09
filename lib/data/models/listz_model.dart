class ListZ {
  ListZ({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.type,
    this.creationDate,
    this.itemCount,
  });

  int id;
  int userId;
  String name;
  String description;
  int type;
  DateTime creationDate;
  int itemCount;

  factory ListZ.fromJson(Map<String, dynamic> json) => ListZ(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        creationDate: DateTime.parse(json["creation_date"]),
        itemCount: json["item_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "description": description,
        "type": type,
        "creation_date": creationDate.toIso8601String(),
        "item_count": itemCount,
      };
}
