// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.phoneNumber,
    this.createdAt,
    this.isActive,
    this.isOnline,
    @required this.userId,
    this.lastSeenAt,
    this.nickname,
    @required this.profileUrl,
  });

  String phoneNumber;
  int createdAt;
  bool isActive;
  bool isOnline;
  String userId;
  int lastSeenAt;
  String nickname;
  String profileUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    phoneNumber: json["phone_number"],
    createdAt: json["created_at"],
    isActive: json["is_active"],
    isOnline: json["is_online"],
    userId: json["user_id"],
    lastSeenAt: json["last_seen_at"],
    nickname: json["nickname"],
    profileUrl: json["profile_url"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "created_at": createdAt,
    "is_active": isActive,
    "is_online": isOnline,
    "user_id": userId,
    "last_seen_at": lastSeenAt,
    "nickname": nickname,
    "profile_url": profileUrl,
  };
}
