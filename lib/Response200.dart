// To parse this JSON data, do
//
//     final response200 = response200FromMap(jsonString);

import 'dart:convert';

Response200 response200FromMap(String str) =>
    Response200.fromMap(json.decode(str));

String response200ToMap(Response200 data) => json.encode(data.toMap());

class Response200 {
  Response200({
    required this.token,
    required this.refreshToken,
    required this.success,
    required this.errors,
  });

  String token;
  String refreshToken;
  bool success;
  dynamic errors;

  factory Response200.fromMap(Map<String, dynamic> json) => Response200(
        token: json["token"],
        refreshToken: json["refreshToken"],
        success: json["success"],
        errors: json["errors"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "refreshToken": refreshToken,
        "success": success,
        "errors": errors,
      };
}
