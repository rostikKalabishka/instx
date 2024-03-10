import 'package:equatable/equatable.dart';

import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final UserModel userModel;
  final String postId;
  final String imageUrl;
  final DateTime createAt;
  final String post;
  final int likeCount;

  const PostModel({
    required this.userModel,
    required this.postId,
    required this.imageUrl,
    required this.createAt,
    required this.post,
    required this.likeCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
  @override
  List<Object?> get props =>
      [userModel, postId, imageUrl, createAt, post, likeCount];

  PostModel copyWith({
    UserModel? userModel,
    String? postId,
    String? imageUrl,
    DateTime? createAt,
    String? post,
    int? likeCount,
  }) {
    return PostModel(
      userModel: userModel ?? this.userModel,
      postId: postId ?? this.postId,
      imageUrl: imageUrl ?? this.imageUrl,
      createAt: createAt ?? this.createAt,
      post: post ?? this.post,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}
