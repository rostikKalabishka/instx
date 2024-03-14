part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.userModel = UserModel.userEmpty,
    this.postList = const [],
    this.statusPage = StatusPage.loading,
    this.error = '',
    this.newImage = '',
  });
  final UserModel userModel;
  final List<LocalEntityPost> postList;
  final StatusPage statusPage;
  final Object error;
  final String newImage;

  @override
  List<Object> get props => [userModel, postList, newImage, error, statusPage];

  ProfileState copyWith({
    UserModel? userModel,
    List<LocalEntityPost>? postList,
    StatusPage? statusPage,
    Object? error,
    String? newImage,
  }) {
    return ProfileState(
        userModel: userModel ?? this.userModel,
        postList: postList ?? this.postList,
        statusPage: statusPage ?? this.statusPage,
        error: error ?? this.error,
        newImage: newImage ?? this.newImage);
  }
}
