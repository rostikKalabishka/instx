part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({this.post = '', this.imagePost = '', this.error = ''});
  final String post;
  final String imagePost;
  final Object error;

  @override
  List<Object> get props => [error, imagePost, post];

  PostState copyWith({
    String? post,
    String? imagePost,
    Object? error,
  }) {
    return PostState(
      post: post ?? this.post,
      imagePost: imagePost ?? this.imagePost,
      error: error ?? this.error,
    );
  }
}
