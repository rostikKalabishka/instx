import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instx/domain/repositories/comment_repository/abstract_comment_repository.dart';
import 'package:instx/domain/repositories/comment_repository/models/comment_model.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

class CommentRepository implements AbstractCommentRepository {
  final commentCollection = FirebaseFirestore.instance.collection('comments');

  @override
  Future<CommentModel> createComment(
      {required String userId, required CommentModel comment}) async {
    try {
      await commentCollection.doc(comment.commentId).set(comment.toJson());
      return comment;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getCommentForPost(
      {required PostModel post}) async {
    try {
      final querySnapshot = await commentCollection
          .where('postModel.postId', isEqualTo: post.postId)
          .get();
      final comments = querySnapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList();
      return comments;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
