import 'package:equatable/equatable.dart';
import 'package:instx/domain/repositories/post_repository/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  final String commentId;
  final String comment;
  final DateTime createAt;
  final String userId;
  final PostModel postModel;

  const CommentModel({
    required this.commentId,
    required this.comment,
    required this.createAt,
    required this.userId,
    required this.postModel,
  });

  static final emptyComment = CommentModel(
      commentId: '',
      comment: '',
      userId: 'userId',
      postModel: PostModel.emptyPost,
      createAt: DateTime.now());

  @override
  List<Object?> get props => [
        commentId,
        comment,
        createAt,
        userId,
        postModel,
      ];

  CommentModel copyWith(
      {String? commentId,
      String? comment,
      DateTime? createAt,
      String? userId,
      PostModel? postModel,
      int? countLike}) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      comment: comment ?? this.comment,
      createAt: createAt ?? this.createAt,
      userId: userId ?? this.userId,
      postModel: postModel ?? this.postModel,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      "commentId": commentId,
      "createAt": createAt.toIso8601String(),
      "comment": comment,
      "userId": userId,
      "postModel": postModel.toJson()
    };
  }
}
