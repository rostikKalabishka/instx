// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentId: json['commentId'] as String,
      comment: json['comment'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      userId: json['userId'] as String,
      postModel: PostModel.fromJson(json['postModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'comment': instance.comment,
      'createAt': instance.createAt.toIso8601String(),
      'userId': instance.userId,
      'postModel': instance.postModel,
    };
