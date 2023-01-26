// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map json) => MessageVO(
      file: json['file'] as String?,
      fileType: json['fileType'] as String?,
      message: json['message'] as String?,
      senderName: json['sender_name'] as String?,
      senderProfilePicture: json['sender_profile_picture'] as String?,
      senderUserId: json['sender_user_id'] as String?,
      timeStamp: json['timestamp'] as String?,
    );

Map<dynamic, dynamic> _$MessageVOToJson(MessageVO instance) => <dynamic, dynamic>{
      'file': instance.file,
      'fileType': instance.fileType,
      'message': instance.message,
      'sender_name': instance.senderName,
      'sender_profile_picture': instance.senderProfilePicture,
      'sender_user_id': instance.senderUserId,
      'timestamp': instance.timeStamp,
    };
