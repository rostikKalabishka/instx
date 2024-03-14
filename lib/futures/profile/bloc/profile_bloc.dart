import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';

import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/allPost/local_entity/local_entity_post.dart';

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
      } else if (event is AddOrRemoveLikeInProfile) {
        await _likeOrRemove(event, emit);
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
    if (state.statusPage != StatusPage.loaded) {
      emit(state.copyWith(statusPage: StatusPage.loading));
    }

    try {
      final UserModel userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);
      final allPost = await _abstractPostRepository.getAllPostCurrentUser(
          userId: event.userId);

      final List<LocalEntityPost> localEntityPosts = [];

      for (final postModel in allPost) {
        final bool isLiked = await _abstractPostRepository.isLiked(
          postModel: postModel,
          currentUserId: event.userId,
        );
        final localEntityPost = LocalEntityPost(
            postModel: postModel,
            isLiked: isLiked,
            likeCounter: postModel.likeUsers.length,
            commentCounter: postModel.commentList.length);
        localEntityPosts.add(localEntityPost);
      }

      emit(
        state.copyWith(
            statusPage: StatusPage.loaded,
            postList: localEntityPosts,
            userModel: userModel,
            newImage: ''),
      );
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }

  Future<void> _likeOrRemove(AddOrRemoveLikeInProfile event, emit) async {
    try {
      await _abstractPostRepository.addOrRemoveLikeOnPost(
          postModel: event.localEntityPost.postModel,
          currentUserId: event.currentUserId);

      final isLiked = await _abstractPostRepository.isLiked(
          postModel: event.localEntityPost.postModel,
          currentUserId: event.currentUserId);
      LocalEntityPost localEntityPost =
          event.localEntityPost.copyWith(isLiked: isLiked);
      List<LocalEntityPost> updatedPostList = List.from(state.postList);
      if (isLiked) {
        updatedPostList[event.index] = localEntityPost.copyWith(
            likeCounter: localEntityPost.likeCounter + 1);
      } else {
        updatedPostList[event.index] = localEntityPost.copyWith(
            likeCounter: localEntityPost.likeCounter - 1);
      }

      emit(state.copyWith(postList: updatedPostList));
    } catch (e) {
      emit(state.copyWith(
        error: e,
      ));
    }
  }
}
