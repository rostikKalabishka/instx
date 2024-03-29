part of 'all_post_bloc.dart';

enum StatusPage { loaded, loading, failure }

class AllPostState extends Equatable {
  const AllPostState(
      {this.error = '',
      this.status = StatusPage.loading,
      this.postList = const [],
      this.commentList = const []});
  final Object error;

  final StatusPage status;

  final List<LocalEntityPost> postList;
  final List<CommentModel> commentList;

  @override
  List<Object> get props => [error, status, postList, commentList];

  AllPostState copyWith({
    Object? error,
    StatusPage? status,
    List<LocalEntityPost>? postList,
    List<CommentModel>? commentList,
  }) {
    return AllPostState(
        error: error ?? this.error,
        status: status ?? this.status,
        postList: postList ?? this.postList,
        commentList: commentList ?? this.commentList);
  }
}
