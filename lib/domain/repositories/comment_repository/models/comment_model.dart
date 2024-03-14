import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String commentId;
  final String comment;
  final DateTime createAt;
  final String userId;
  final String postId;

  const CommentModel({
    required this.commentId,
    required this.comment,
    required this.createAt,
    required this.userId,
    required this.postId,
  });

  @override
  List<Object?> get props => [
        commentId,
        comment,
        createAt,
        userId,
        postId,
      ];

  CommentModel copyWith(
      {String? commentId,
      String? comment,
      DateTime? createAt,
      String? userId,
      String? postId,
      int? countLike}) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      comment: comment ?? this.comment,
      createAt: createAt ?? this.createAt,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }
}
