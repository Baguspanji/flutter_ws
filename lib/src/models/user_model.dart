// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

class UserData {
  UserData({
    this.user,
    this.pass,
  });

  String user;
  String pass;

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: json["user"],
        pass: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "pass": pass,
      };
}
