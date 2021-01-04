// To parse this JSON data, do
//
//     final chatChannelModel = chatChannelModelFromJson(jsonString);

import 'dart:convert';

ChatChannelModel chatChannelModelFromJson(String str) => ChatChannelModel.fromJson(json.decode(str));

String chatChannelModelToJson(ChatChannelModel data) => json.encode(data.toJson());

class ChatChannelModel {
  ChatChannelModel({
    this.name,
    this.participantCount,
    this.customType,
    this.isEphemeral,
    this.channelUrl,
    this.createdAt,
    this.coverUrl,
    this.freeze,
    this.isDynamicPartitioned,
    this.maxLengthMessage,
    this.data,
    this.operators,
  });

  String name;
  int participantCount;
  String customType;
  bool isEphemeral;
  String channelUrl;
  int createdAt;
  String coverUrl;
  bool freeze;
  bool isDynamicPartitioned;
  int maxLengthMessage;
  String data;
  List<Operator> operators;

  factory ChatChannelModel.fromJson(Map<String, dynamic> json) => ChatChannelModel(
    name: json["name"],
    participantCount: json["participant_count"],
    customType: json["custom_type"],
    isEphemeral: json["is_ephemeral"],
    channelUrl: json["channel_url"],
    createdAt: json["created_at"],
    coverUrl: json["cover_url"],
    freeze: json["freeze"],
    isDynamicPartitioned: json["is_dynamic_partitioned"],
    maxLengthMessage: json["max_length_message"],
    data: json["data"],
    operators: List<Operator>.from(json["operators"].map((x) => Operator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "participant_count": participantCount,
    "custom_type": customType,
    "is_ephemeral": isEphemeral,
    "channel_url": channelUrl,
    "created_at": createdAt,
    "cover_url": coverUrl,
    "freeze": freeze,
    "is_dynamic_partitioned": isDynamicPartitioned,
    "max_length_message": maxLengthMessage,
    "data": data,
    "operators": List<dynamic>.from(operators.map((x) => x.toJson())),
  };
}

class Operator {
  Operator({
    this.nickname,
    this.userId,
    this.profileUrl,
  });

  String nickname;
  String userId;
  String profileUrl;

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
    nickname: json["nickname"],
    userId: json["user_id"],
    profileUrl: json["profile_url"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "user_id": userId,
    "profile_url": profileUrl,
  };
}
