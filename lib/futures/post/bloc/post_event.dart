part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostEvent extends PostEvent {
  const CreatePostEvent(
      {required this.userId, required this.post, required this.imagePostList});
  final String userId;
  final String post;
  final List<String> imagePostList;

  @override
  List<Object> get props => [
        userId,
        post,
        imagePostList,
      ];
}

class LoadInfoEvent extends PostEvent {
  final String userId;

  const LoadInfoEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SelectImageEvent extends PostEvent {
  final double maxHeight;
  final double maxWidth;
  final int imageQuality;
  final Color toolbarWidgetColor;
  final Color toolbarColor;

  const SelectImageEvent({
    required this.imageQuality,
    required this.maxWidth,
    required this.maxHeight,
    required this.toolbarWidgetColor,
    required this.toolbarColor,
  });

  @override
  List<Object> get props =>
      [maxHeight, maxWidth, imageQuality, toolbarColor, toolbarWidgetColor];
}

class RemoveImage extends PostEvent {
  final String image;

  const RemoveImage({required this.image});

  @override
  List<Object> get props => [image];
}
