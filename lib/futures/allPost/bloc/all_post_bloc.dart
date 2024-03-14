import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';

import 'package:instx/futures/allPost/local_entity/local_entity_post.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final AbstractPostRepository _abstractPostRepository;
  AllPostBloc(AbstractPostRepository abstractPostRepository)
      : _abstractPostRepository = abstractPostRepository,
        super(const AllPostState()) {
    on<AllPostEvent>((event, emit) async {
      if (event is AllPostLoaded) {
        await _allPostLoaded(event, emit);
      } else if (event is AddOrRemoveLike) {
        await _likeOrRemove(event, emit);
      }
    });
  }

  Future<void> _allPostLoaded(AllPostLoaded event, emit) async {
    if (state.status != StatusPage.loaded) {
      emit(state.copyWith(status: StatusPage.loading));
    }

    try {
      final allPost = await _abstractPostRepository.getAllPost();

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
          status: StatusPage.loaded,
          postList: localEntityPosts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StatusPage.failure, error: e));
    }
  }

  Future<void> _likeOrRemove(AddOrRemoveLike event, emit) async {
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
