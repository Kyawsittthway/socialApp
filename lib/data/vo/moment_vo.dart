import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "post_images")
  List<String>? postImages;

  MomentVO({this.id, this.description, this.profilePicture, this.userName,
      this.postImages});

  factory MomentVO.fromJson(Map<String, dynamic> json) => _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}