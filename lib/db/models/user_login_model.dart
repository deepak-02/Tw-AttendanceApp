// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  Data? data;
  bool? success;

  UserLoginModel({
    this.data,
    this.success,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  List<User>? user;
  bool? success;

  Data({
    this.user,
    this.success,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
