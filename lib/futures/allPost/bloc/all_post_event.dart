part of 'all_post_bloc.dart';

sealed class AllPostEvent extends Equatable {
  const AllPostEvent();

  @override
  List<Object> get props => [];
}

class AllPostLoaded extends AllPostEvent {
  final String userId;

  const AllPostLoaded({required this.userId});

  @override
  List<Object> get props => super.props..add(userId);
}

class LoadComment extends AllPostEvent {
  final PostModel postModel;
  final BuildContext context;

  const LoadComment({required this.postModel, required this.context});

  @override
  List<Object> get props => super.props..addAll([postModel, context]);
}

class AddComment extends AllPostEvent {
  final String comment;
  final String userId;
  final PostModel postModel;

  const AddComment(
      {required this.comment, required this.userId, required this.postModel});

  @override
  List<Object> get props => super.props..addAll([comment, userId, postModel]);
}

class AddOrRemoveLike extends AllPostEvent {
  final LocalEntityPost localEntityPost;
  final String currentUserId;
  final int index;

  const AddOrRemoveLike(
      {required this.localEntityPost,
      required this.currentUserId,
      required this.index});
  @override
  List<Object> get props => [localEntityPost, currentUserId, index];
}
