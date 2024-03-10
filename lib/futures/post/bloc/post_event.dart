part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostEvent extends PostEvent {
  const CreatePostEvent(
      {required this.userId, required this.post, required this.imageUrl});
  final String userId;
  final String post;
  final String imageUrl;

  @override
  List<Object> get props => [
        userId,
        post,
        imageUrl,
      ];
}
