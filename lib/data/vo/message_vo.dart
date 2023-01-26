import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable(anyMap: true,explicitToJson: true)
class MessageVO {
  @JsonKey(name: "file")
  String? file;

  @JsonKey(name: "fileType")
  String? fileType;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "sender_name")
  String? senderName;

  @JsonKey(name: "sender_profile_picture")
  String? senderProfilePicture;

  @JsonKey(name: "sender_user_id")
  String? senderUserId;

  @JsonKey(name: "timestamp")
  String? timeStamp;

  MessageVO({this.file, this.fileType, this.message, this.senderName,
      this.senderProfilePicture, this.senderUserId, this.timeStamp});

  factory MessageVO.fromJson(Map json) => _$MessageVOFromJson(json);

  Map<dynamic, dynamic> toJson() => _$MessageVOToJson(this);
}
