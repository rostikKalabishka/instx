// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      postId: json['postId'] as String,
      imageUrlList: (json['imageUrlList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createAt: DateTime.parse(json['createAt'] as String),
      post: json['post'] as String,
      likeUsers:
          (json['likeUsers'] as List<dynamic>).map((e) => e as String).toList(),
      commentList: (json['commentList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'userModel': instance.userModel,
      'postId': instance.postId,
      'imageUrlList': instance.imageUrlList,
      'createAt': instance.createAt.toIso8601String(),
      'post': instance.post,
      'likeUsers': instance.likeUsers,
      'commentList': instance.commentList,
    };
