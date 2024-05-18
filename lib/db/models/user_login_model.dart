// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  List<User>? user;
  bool? success;

  UserLogin({
    this.user,
    this.success,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    user: json["user"] == null ? [] : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
    "success": success,
  };
}

class User {
  String? id;
  String? pimage;
  String? pemail;
  String? paddress;
  String? jobInfo;
  String? name;
  String? managerName;
  String? teams;

  User({
    this.id,
    this.pimage,
    this.pemail,
    this.paddress,
    this.jobInfo,
    this.name,
    this.managerName,
    this.teams,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    pimage: json["pimage"],
    pemail: json["pemail"],
    paddress: json["paddress"],
    jobInfo: json["jobInfo"],
    name: json["name"],
    managerName: json["managerName"],
    teams: json["teams"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "pimage": pimage,
    "pemail": pemail,
    "paddress": paddress,
    "jobInfo": jobInfo,
    "name": name,
    "managerName": managerName,
    "teams": teams,
  };
}
