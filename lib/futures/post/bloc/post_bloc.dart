import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/models.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AbstractPostRepository _abstractPostRepository;
  final AbstractAuthRepository _abstractAuthRepository;
  PostBloc(AbstractPostRepository abstractPostRepository,
      AbstractAuthRepository abstractAuthRepository)
      : _abstractPostRepository = abstractPostRepository,
        _abstractAuthRepository = abstractAuthRepository,
        super(const PostState()) {
    on<PostEvent>((event, emit) async {
      if (event is CreatePostEvent) {
        await _createPost(event, emit);
      } else if (event is LoadInfoEvent) {
        await _loadInfo(event, emit);
      } else if (event is SelectImageEvent) {
        await _selectImageEvent(event, emit);
      } else if (event is RemoveImage) {
        await _removeImageFromList(event, emit);
      }
    });
  }
  Future<void> _createPost(CreatePostEvent event, emit) async {
    try {
      final userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);

      PostModel postModel = PostModel.emptyPost.copyWith(
          userModel: userModel,
          post: event.post,
          imageUrlList: event.imagePostList);
      await _abstractPostRepository.createPost(postModel);
      emit(state.copyWith(imagePostList: []));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadInfo(LoadInfoEvent event, emit) async {
    emit(state.copyWith(status: UserAuthStatus.loading));
    try {
      final userModel = await _abstractAuthRepository.getUserById(
        userId: event.userId,
      );

      emit(state.copyWith(
          status: UserAuthStatus.loaded,
          userModel: userModel,
          imagePostList: []));
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.failure));
    }
  }

  Future<void> _selectImageEvent(SelectImageEvent event, emit) async {
    try {
      List<String> listImages = state.imagePostList;

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: event.maxHeight,
          maxWidth: event.maxWidth,
          imageQuality: event.imageQuality);
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
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (croppedFile != null) {
          List<String> updateListImages = List.from(listImages);
          updateListImages.add(croppedFile.path);

          emit(state.copyWith(imagePostList: updateListImages));
        }
      }
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.failure));
    }
  }

  Future<void> _removeImageFromList(RemoveImage event, emit) async {
    try {
      List<String> listImages = state.imagePostList;

      List<String> updateListImages = List.from(listImages);
      updateListImages.remove(event.image);
      emit(state.copyWith(imagePostList: updateListImages));
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.failure));
    }
  }
}
