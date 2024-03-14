import 'package:equatable/equatable.dart';

import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

class LocalEntityPost extends Equatable {
  final PostModel postModel;
  final bool isLiked;
  final int likeCounter;
  final int commentCounter;

  const LocalEntityPost(
      {required this.postModel,
      this.isLiked = false,
      required this.likeCounter,
      required this.commentCounter});

  @override
  List<Object?> get props => [postModel, isLiked];

  LocalEntityPost copyWith({
    PostModel? postModel,
    bool? isLiked,
    int? likeCounter,
    int? commentCounter,
  }) {
    return LocalEntityPost(
      postModel: postModel ?? this.postModel,
      isLiked: isLiked ?? this.isLiked,
      likeCounter: likeCounter ?? this.likeCounter,
      commentCounter: commentCounter ?? this.commentCounter,
    );
  }
}
