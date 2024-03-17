// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'followers_page_bloc.dart';

class FollowersPageState extends Equatable {
  const FollowersPageState(
      {this.statusPage = StatusPage.loading,
      this.userModelList = const [],
      this.error = ''});
  final StatusPage statusPage;
  final List<UserModel> userModelList;
  final Object error;
  @override
  List<Object> get props => [statusPage, userModelList, error];

  FollowersPageState copyWith({
    StatusPage? statusPage,
    List<UserModel>? userModelList,
    Object? error,
  }) {
    return FollowersPageState(
      statusPage: statusPage ?? this.statusPage,
      userModelList: userModelList ?? this.userModelList,
      error: error ?? this.error,
    );
  }
}
