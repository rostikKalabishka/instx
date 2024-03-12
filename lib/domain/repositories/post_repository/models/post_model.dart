import 'package:equatable/equatable.dart';

import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final UserModel userModel;
  final String postId;
  final List<String> imageUrlList;
  final DateTime createAt;
  final String post;
  final List<String> likeUsers;
  final List<String> commentList;

  const PostModel({
    required this.userModel,
    required this.postId,
    required this.imageUrlList,
    required this.createAt,
    required this.post,
    required this.likeUsers,
    required this.commentList,
  });

  static final emptyPost = PostModel(
      createAt: DateTime.now(),
      userModel: UserModel.userEmpty,
      postId: '',
      imageUrlList: const [],
      post: '',
      commentList: const [],
      likeUsers: const []);

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userModel': userModel.toJson(),
        'postId': postId,
        'imageUrlList': imageUrlList,
        'createAt': createAt.toIso8601String(),
        'post': post,
        'commentList': commentList,
        'likeUsers': likeUsers,
      };

  @override
  List<Object?> get props =>
      [userModel, postId, imageUrlList, createAt, post, likeUsers];

  PostModel copyWith({
    UserModel? userModel,
    String? postId,
    List<String>? imageUrlList,
    DateTime? createAt,
    String? post,
    List<String>? likeUsers,
    List<String>? commentList,
  }) {
    return PostModel(
      userModel: userModel ?? this.userModel,
      postId: postId ?? this.postId,
      imageUrlList: imageUrlList ?? this.imageUrlList,
      createAt: createAt ?? this.createAt,
      post: post ?? this.post,
      likeUsers: likeUsers ?? this.likeUsers,
      commentList: commentList ?? this.commentList,
    );
  }
}
