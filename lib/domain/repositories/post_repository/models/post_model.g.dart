// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      postId: json['postId'] as String,
      imageUrl: json['imageUrl'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      post: json['post'] as String,
      likeCount: json['likeCount'] as int,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'userModel': instance.userModel,
      'postId': instance.postId,
      'imageUrl': instance.imageUrl,
      'createAt': instance.createAt.toIso8601String(),
      'post': instance.post,
      'likeCount': instance.likeCount,
    };
