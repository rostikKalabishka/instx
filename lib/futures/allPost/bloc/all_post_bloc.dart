import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/comment_repository/abstract_comment_repository.dart';
import 'package:instx/domain/repositories/comment_repository/models/comment_model.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:instx/futures/allPost/local_entity/local_entity_post.dart';
import 'package:instx/futures/allPost/widget/comment_list.dart';
import 'package:instx/ui/components/show_modal_menu_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final AbstractPostRepository _abstractPostRepository;
  final AbstractCommentRepository _abstractCommentRepository;
  AllPostBloc(
      {required AbstractPostRepository abstractPostRepository,
      required AbstractCommentRepository abstractCommentRepository})
      : _abstractPostRepository = abstractPostRepository,
        _abstractCommentRepository = abstractCommentRepository,
        super(const AllPostState()) {
    on<AllPostEvent>((event, emit) async {
      if (event is AllPostLoaded) {
        await _allPostLoaded(event, emit);
      } else if (event is AddOrRemoveLike) {
        await _likeOrRemove(event, emit);
      } else if (event is LoadComment) {
        await _loadComment(event, emit);
      } else if (event is AddComment) {
        await _createComment(event, emit);
      }
    });
  }

  Future<void> _allPostLoaded(AllPostLoaded event, emit) async {
    if (state.status != StatusPage.loaded) {
      emit(state.copyWith(status: StatusPage.loading));
    } //

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

  Future<void> _createComment(AddComment event, emit) async {
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

  Future<void> _loadComment(LoadComment event, emit) async {
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
