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
