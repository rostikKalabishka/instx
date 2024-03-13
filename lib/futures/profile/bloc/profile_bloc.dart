import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
      } else if (event is SelectImageEvent) {
        await _selectImageEvent(event, emit);
      } else if (event is UpdateUserInfoEvent) {
        await _updateUserInfo(event, emit);
      }
    });
  }

  Future<void> _selectImageEvent(SelectImageEvent event, emit) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: event.maxHeight,
        maxWidth: event.maxWidth,
        imageQuality: event.imageQuality,
      );
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: event.toolbarColor,
              toolbarWidgetColor: event.toolbarWidgetColor,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (croppedFile != null) {
          emit(state.copyWith(newImage: croppedFile.path));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        error: e,
      ));
    }
  }

  Future<void> _updateUserInfo(UpdateUserInfoEvent event, emit) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      UserModel userModel = state.userModel.copyWith(
          status: event.updateStatus.trim(),
          username: event.updateUserName.trim());
      final newImage = await _abstractAuthRepository.uploadPicture(
          state.newImage, state.userModel.uid);
      if (newImage.isNotEmpty) {
        userModel = userModel.copyWith(imageUrl: newImage);
      }
      await _abstractAuthRepository.updateUserInfo(userModel);
      emit(state.copyWith(userModel: userModel, newImage: ''));
      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
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
          newImage: '',
          postList: userPostList));
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }
}
