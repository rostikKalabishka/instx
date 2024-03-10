import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository implements AbstractPostRepository {
  final usersCollection = FirebaseFirestore.instance.collection('post');
  @override
  Future<PostModel> createPost(PostModel postModel) async {
    try {
      postModel = postModel.copyWith(
          createAt: DateTime.now(), postId: const Uuid().v1());

      await usersCollection.doc(postModel.postId).set(postModel.toJson());
      return postModel;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPost() async {
    try {
      return usersCollection.get().then((value) =>
          value.docs.map((e) => PostModel.fromJson(e.data())).toList());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPostCurrentUser(
      {required String userId}) async {
    try {
      return usersCollection.where('userId', isEqualTo: userId).get().then(
          (value) =>
              value.docs.map((e) => PostModel.fromJson(e.data())).toList());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }
}
