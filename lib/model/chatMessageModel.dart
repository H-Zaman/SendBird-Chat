// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

ChatMessageModel chatMessageModelFromJson(String str) => ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) => json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    this.messageSurvivalSeconds,
    this.customType,
    this.mentionedUsers,
    this.translations,
    this.updatedAt,
    this.isOpMsg,
    this.isRemoved,
    this.user,
    this.file,
    this.message,
    this.data,
    this.silent,
    this.type,
    this.createdAt,
    this.mentionType,
    this.channelUrl,
    this.messageId,
  });

  int messageSurvivalSeconds;
  String customType;
  List<dynamic> mentionedUsers;
  FileClass translations;
  int updatedAt;
  bool isOpMsg;
  bool isRemoved;
  User user;
  FileClass file;
  String message;
  String data;
  bool silent;
  String type;
  int createdAt;
  String mentionType;
  String channelUrl;
  int messageId;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    messageSurvivalSeconds: json["message_survival_seconds"],
    customType: json["custom_type"],
    mentionedUsers: List<dynamic>.from(json["mentioned_users"].map((x) => x)),
    translations: FileClass.fromJson(json["translations"]),
    updatedAt: json["updated_at"],
    isOpMsg: json["is_op_msg"],
    isRemoved: json["is_removed"],
    user: User.fromJson(json["user"]),
    file: FileClass.fromJson(json["file"]),
    message: json["message"],
    data: json["data"],
    silent: json["silent"],
    type: json["type"],
    createdAt: json["created_at"],
    mentionType: json["mention_type"],
    channelUrl: json["channel_url"],
    messageId: json["message_id"],
  );

  Map<String, dynamic> toJson() => {
    "message_survival_seconds": messageSurvivalSeconds,
    "custom_type": customType,
    "mentioned_users": List<dynamic>.from(mentionedUsers.map((x) => x)),
    "translations": translations.toJson(),
    "updated_at": updatedAt,
    "is_op_msg": isOpMsg,
    "is_removed": isRemoved,
    "user": user.toJson(),
    "file": file.toJson(),
    "message": message,
    "data": data,
    "silent": silent,
    "type": type,
    "created_at": createdAt,
    "mention_type": mentionType,
    "channel_url": channelUrl,
    "message_id": messageId,
  };
}

class FileClass {
  FileClass();

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
  );

  Map<String, dynamic> toJson() => {
  };
}

class User {
  User({
    this.requireAuthForProfileImage,
    this.isActive,
    this.role,
    this.userId,
    this.nickname,
    this.profileUrl,
    this.metadata,
  });

  bool requireAuthForProfileImage;
  bool isActive;
  String role;
  String userId;
  String nickname;
  String profileUrl;
  FileClass metadata;

  factory User.fromJson(Map<String, dynamic> json) => User(
    requireAuthForProfileImage: json["require_auth_for_profile_image"],
    isActive: json["is_active"],
    role: json["role"],
    userId: json["user_id"],
    nickname: json["nickname"],
    profileUrl: json["profile_url"],
    metadata: FileClass.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "require_auth_for_profile_image": requireAuthForProfileImage,
    "is_active": isActive,
    "role": role,
    "user_id": userId,
    "nickname": nickname,
    "profile_url": profileUrl,
    "metadata": metadata.toJson(),
  };
}
