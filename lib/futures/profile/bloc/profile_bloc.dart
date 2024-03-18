import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instx/domain/repositories/comment_repository/abstract_comment_repository.dart';
import 'package:instx/domain/repositories/comment_repository/models/comment_model.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/allPost/local_entity/local_entity_post.dart';
import 'package:instx/futures/allPost/widget/comment_list.dart';
import 'package:instx/futures/profile/local_entity/user_local_entity.dart';
import 'package:instx/ui/components/show_modal_menu_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AbstractAuthRepository _abstractAuthRepository;
  final AbstractPostRepository _abstractPostRepository;
  final AbstractCommentRepository _abstractCommentRepository;
  ProfileBloc(
      {required AbstractAuthRepository abstractAuthRepository,
      required AbstractPostRepository abstractPostRepository,
      required AbstractCommentRepository abstractCommentRepository})
      : _abstractAuthRepository = abstractAuthRepository,
        _abstractPostRepository = abstractPostRepository,
        _abstractCommentRepository = abstractCommentRepository,
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
      } else if (event is AddCommentProfile) {
        await _createComment(event, emit);
      } else if (event is LoadCommentProfile) {
        await _loadComment(event, emit);
      } else if (event is FollowingEvent) {
        await _follow(event, emit);
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
      UserLocalEntity userLocalEntity = state.userLocalEntity;
      userLocalEntity.userModel.copyWith(
          status: event.updateStatus.trim(),
          username: event.updateUserName.trim());
      final newImage = await _abstractAuthRepository.uploadPicture(
          state.newImage, state.userLocalEntity.userModel.uid);
      if (newImage.isNotEmpty) {
        userLocalEntity.userModel.copyWith(imageUrl: newImage);
      }
      await _abstractAuthRepository.updateUserInfo(userLocalEntity.userModel);
      emit(state.copyWith(userLocalEntity: userLocalEntity, newImage: ''));
      autoRouter.pop();
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }

  Future<void> _createComment(AddCommentProfile event, emit) async {
    try {
      List<CommentModel> oldArrComment = state.commentList;
      CommentModel commentModel = CommentModel(
          commentId: const Uuid().v1(),
          comment: event.comment,
          userId: event.userId,
          postModel: event.postModel,
          createAt: DateTime.now());
      List<CommentModel> newArrComment = List.from(oldArrComment)
        ..add(commentModel);

      emit(state.copyWith(commentList: newArrComment));
      await _abstractCommentRepository.createComment(
          userId: event.userId, comment: commentModel);
      await _abstractPostRepository.updatePost(
          postModel: event.postModel.copyWith(
              commentList: newArrComment.map((e) => e.commentId).toList()));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadComment(LoadCommentProfile event, emit) async {
    try {
      List<CommentModel> allCommentsForPost = await _abstractCommentRepository
          .getCommentForPost(post: event.postModel);

      emit(state.copyWith(commentList: allCommentsForPost));

      showModalMenuBottomSheet(
          context: event.context,
          modalHeight: MediaQuery.of(event.context).size.height * 0.9,
          child: CommentListWidget(
            commentList: allCommentsForPost,
            postModel: event.postModel,
          ));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _follow(FollowingEvent event, emit) async {
    // emit(state.copyWith(buttonFollowingState: ButtonFollowingState.inProcess));
    try {
      final currentUser = await _abstractAuthRepository.getUserById(
          userId: event.currentAuthUserId);
      await _abstractAuthRepository.following(
          userModel: state.userLocalEntity.userModel, currentUser: currentUser);
      if (state.userLocalEntity.isFollowing == false) {
        emit(state.copyWith(
            userLocalEntity: state.userLocalEntity.copyWith(
                isFollowing: true,
                followerCounter: state.userLocalEntity.followerCounter + 1)));
      } else {
        emit(state.copyWith(
            userLocalEntity: state.userLocalEntity.copyWith(
                isFollowing: false,
                followerCounter: state.userLocalEntity.followerCounter - 1)));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadedInfo(LoadedInfo event, emit) async {
    if (state.statusPage != StatusPage.loaded) {
      emit(state.copyWith(statusPage: StatusPage.loading));
    }

    try {
      final UserLocalEntity userLocalEntity = UserLocalEntity(
          userModel:
              await _abstractAuthRepository.getUserById(userId: event.userId));

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
            userLocalEntity: userLocalEntity,
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
