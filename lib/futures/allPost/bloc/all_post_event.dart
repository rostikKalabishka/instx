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
