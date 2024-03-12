part of 'post_bloc.dart';

enum UserAuthStatus { loaded, loading, failure }

class PostState extends Equatable {
  const PostState(
      {this.post = '',
      this.imagePostList = const [],
      this.error = '',
      this.userModel = UserModel.userEmpty,
      this.status = UserAuthStatus.loading});
  final String post;
  final List<String> imagePostList;
  final Object error;
  final UserModel userModel;
  final UserAuthStatus status;

  @override
  List<Object> get props => [error, imagePostList, post, status];

  PostState copyWith(
      {String? post,
      List<String>? imagePostList,
      Object? error,
      UserModel? userModel,
      UserAuthStatus? status}) {
    return PostState(
        post: post ?? this.post,
        imagePostList: imagePostList ?? this.imagePostList,
        error: error ?? this.error,
        userModel: userModel ?? this.userModel,
        status: status ?? this.status);
  }
}
