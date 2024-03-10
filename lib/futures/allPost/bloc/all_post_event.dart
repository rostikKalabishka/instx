part of 'all_post_bloc.dart';

sealed class AllPostEvent extends Equatable {
  const AllPostEvent();

  @override
  List<Object> get props => [];
}

class AllPostLoaded extends AllPostEvent {}
