part of 'followers_page_bloc.dart';

sealed class FollowersPageEvent extends Equatable {
  const FollowersPageEvent();

  @override
  List<Object> get props => [];
}

class SearchFollowersEvent extends FollowersPageEvent {
  final String text;
  final String userId;

  const SearchFollowersEvent({required this.text, required this.userId});

  @override
  List<Object> get props => super.props..addAll([text]);
}

class LoadAllFollowers extends FollowersPageEvent {
  final String userId;

  const LoadAllFollowers({required this.userId});

  @override
  List<Object> get props => super.props..addAll([userId]);
}
