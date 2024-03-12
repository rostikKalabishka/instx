import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AbstractAuthRepository _abstractAuthRepository;
  final AbstractPostRepository _abstractPostRepository;
  ProfileBloc(
      {required AbstractAuthRepository abstractAuthRepository,
      required AbstractPostRepository abstractPostRepository})
      : _abstractAuthRepository = abstractAuthRepository,
        _abstractPostRepository = abstractPostRepository,
        super(const ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is LoadedInfo) {
        await _loadedInfo(event, emit);
      }
    });
  }
  Future<void> _loadedInfo(LoadedInfo event, emit) async {
    emit(state.copyWith(
      statusPage: StatusPage.loading,
    ));

    try {
      final UserModel userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);

      final userPostList = await _abstractPostRepository.getAllPostCurrentUser(
          userId: event.userId);

      emit(state.copyWith(
          statusPage: StatusPage.loaded,
          userModel: userModel,
          postList: userPostList));
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }
}
