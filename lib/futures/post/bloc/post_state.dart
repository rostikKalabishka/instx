part of 'post_bloc.dart';

enum UserAuthStatus { loaded, loading, failure }

class PostState extends Equatable {
  const PostState(
      {this.post = '',
      this.imagePost = '',
      this.error = '',
      this.userModel = UserModel.userEmpty,
      this.status = UserAuthStatus.loading});
  final String post;
  final String imagePost;
  final Object error;
  final UserModel userModel;
  final UserAuthStatus status;

  @override
  List<Object> get props => [error, imagePost, post, status];

  PostState copyWith(
      {String? post,
      String? imagePost,
      Object? error,
      UserModel? userModel,
      UserAuthStatus? status}) {
    return PostState(
        post: post ?? this.post,
        imagePost: imagePost ?? this.imagePost,
        error: error ?? this.error,
        userModel: userModel ?? this.userModel,
        status: status ?? this.status);
  }
}
