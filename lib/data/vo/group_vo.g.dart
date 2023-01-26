// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupVO _$GroupVOFromJson(Map json) => GroupVO(
      groupName: json['name'] as String?,
      groupId: json['groupId'] as String?,
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      messages: (json['messages'] as Map?)?.map(
        (k, e) => MapEntry(k as String, MessageVO.fromJson(e as Map)),
      ),
    );

Map<String, dynamic> _$GroupVOToJson(GroupVO instance) => <String, dynamic>{
      'name': instance.groupName,
      'groupId': instance.groupId,
      'userIds': instance.userIds,
      'messages': instance.messages?.map((k, e) => MapEntry(k, e.toJson())),
    };
