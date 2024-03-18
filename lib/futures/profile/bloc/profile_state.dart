part of 'profile_bloc.dart';

enum ButtonFollowingState { inProcess, success, unknown }

class ProfileState extends Equatable {
  const ProfileState(
      {this.userLocalEntity = const UserLocalEntity(
          userModel: UserModel.userEmpty, isFollowing: false),
      this.postList = const [],
      this.statusPage = StatusPage.loading,
      this.error = '',
      this.newImage = '',
      this.commentList = const [],
      this.buttonFollowingState = ButtonFollowingState.unknown});
  final UserLocalEntity userLocalEntity;
  final List<LocalEntityPost> postList;
  final StatusPage statusPage;
  final Object error;
  final String newImage;
  final List<CommentModel> commentList;
  final ButtonFollowingState buttonFollowingState;

  @override
  List<Object> get props => [
        userLocalEntity,
        postList,
        newImage,
        error,
        statusPage,
        buttonFollowingState
      ];

  ProfileState copyWith(
      {UserLocalEntity? userLocalEntity,
      List<LocalEntityPost>? postList,
      StatusPage? statusPage,
      Object? error,
      String? newImage,
      List<CommentModel>? commentList,
      ButtonFollowingState? buttonFollowingState}) {
    return ProfileState(
        userLocalEntity: userLocalEntity ?? this.userLocalEntity,
        postList: postList ?? this.postList,
        statusPage: statusPage ?? this.statusPage,
        error: error ?? this.error,
        newImage: newImage ?? this.newImage,
        commentList: commentList ?? this.commentList,
        buttonFollowingState:
            buttonFollowingState ?? this.buttonFollowingState);
  }
}
