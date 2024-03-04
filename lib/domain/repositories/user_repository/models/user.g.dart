// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'password': instance.password,
      'email': instance.email,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
      'createAt': instance.createAt.toIso8601String(),
    };
