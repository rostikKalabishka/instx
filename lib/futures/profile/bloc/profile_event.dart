part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadedInfo extends ProfileEvent {
  final String userId;
  const LoadedInfo({
    required this.userId,
  });
  @override
  List<Object> get props => super.props..add(userId);
}

class AddOrRemoveLikeInProfile extends ProfileEvent {
  final LocalEntityPost localEntityPost;
  final String currentUserId;
  final int index;

  const AddOrRemoveLikeInProfile(
      {required this.localEntityPost,
      required this.currentUserId,
      required this.index});
  @override
  List<Object> get props => [localEntityPost, currentUserId, index];
}

class UpdateUserInfoEvent extends ProfileEvent {
  final BuildContext context;
  final String updateUserName;
  final String updateStatus;
  const UpdateUserInfoEvent({
    required this.updateUserName,
    required this.updateStatus,
    required this.context,
  });
  @override
  List<Object> get props =>
      super.props..addAll([updateUserName, updateStatus, context]);
}

class SelectImageEvent extends ProfileEvent {
  final String imageUrl;
  final double maxHeight;
  final double maxWidth;
  final int imageQuality;
  final Color toolbarWidgetColor;
  final Color toolbarColor;
  const SelectImageEvent({
    required this.imageUrl,
    required this.maxHeight,
    required this.maxWidth,
    required this.imageQuality,
    required this.toolbarWidgetColor,
    required this.toolbarColor,
  });
  @override
  List<Object> get props => super.props
    ..addAll(
        [maxHeight, maxWidth, imageQuality, toolbarWidgetColor, toolbarColor]);
}
