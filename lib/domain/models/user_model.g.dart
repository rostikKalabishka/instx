// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'username': instance.username,
      'createAt': instance.createAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };
