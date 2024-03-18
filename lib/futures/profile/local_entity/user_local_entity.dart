import 'package:equatable/equatable.dart';

import 'package:instx/domain/repositories/user_repository/models/user.dart';

class UserLocalEntity extends Equatable {
  final UserModel userModel;
  final bool isFollowing;
  final int followerCounter;

  const UserLocalEntity(
      {this.userModel = UserModel.userEmpty,
      this.isFollowing = false,
      this.followerCounter = 0});

  @override
  List<Object?> get props => [userModel, isFollowing, followerCounter];

  UserLocalEntity copyWith(
      {UserModel? userModel, bool? isFollowing, int? followerCounter}) {
    return UserLocalEntity(
        userModel: userModel ?? this.userModel,
        isFollowing: isFollowing ?? this.isFollowing,
        followerCounter: followerCounter ?? this.followerCounter);
  }
}
