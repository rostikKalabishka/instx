// ignore_for_file: public_member_api_docs, sort_constructors_first
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
