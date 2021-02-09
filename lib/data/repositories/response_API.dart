import 'dart:convert';

ResponseAPI responseFromJson(String str) =>
    ResponseAPI.fromJson(json.decode(str));

String responseToJson(ResponseAPI data) => json.encode(data.toJson());

class ResponseAPI {
  ResponseAPI({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  dynamic data;

  factory ResponseAPI.fromJson(Map<String, dynamic> json) => ResponseAPI(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
