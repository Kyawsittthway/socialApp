

import 'package:json_annotation/json_annotation.dart';

import 'message_vo.dart';

part 'group_vo.g.dart';

@JsonSerializable(anyMap: true,explicitToJson: true)
class GroupVO{
  @JsonKey(name:"name")
  String? groupName;

  @JsonKey(name:"groupId")
  String? groupId;

  @JsonKey(name:"userIds")
  List<String>? userIds;

  @JsonKey(name:"messages")
  Map<String, MessageVO>? messages;



  GroupVO({this.groupName, this.groupId,this.userIds, required this.messages});


  factory GroupVO.fromJson(Map json) => _$GroupVOFromJson(json);

  Map<dynamic, dynamic> toJson() => _$GroupVOToJson(this);
}