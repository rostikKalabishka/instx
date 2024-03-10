part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.userModel = UserModel.userEmpty,
    this.postList = const [],
    this.statusPage = StatusPage.loading,
    this.error = '',
  });
  final UserModel userModel;
  final List<PostModel> postList;
  final StatusPage statusPage;
  final Object error;
  @override
  List<Object> get props => [userModel, postList];

  ProfileState copyWith({
    UserModel? userModel,
    List<PostModel>? postList,
    StatusPage? statusPage,
    Object? error,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      postList: postList ?? this.postList,
      statusPage: statusPage ?? this.statusPage,
      error: error ?? this.error,
    );
  }
}
