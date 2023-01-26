// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map json) => UserVO(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profileImage: json['profile_image'] as String?,
      contact: (json['contacts'] as List<dynamic>?)
          ?.map((e) => UserVO.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'profile_image': instance.profileImage,
      'contacts': instance.contact,
    };
