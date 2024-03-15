import 'dart:developer';
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository implements AbstractPostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<PostModel> createPost(PostModel postModel) async {
    try {
      postModel = postModel.copyWith(
          createAt: DateTime.now(), postId: const Uuid().v1());

      for (int i = 0; i < postModel.imageUrlList.length; i++) {
        File imageFile = File(postModel.imageUrlList[i]);
        Reference referenceStorageRef = FirebaseStorage.instance.ref().child(
            '${postModel.userModel.uid}/${postModel.postId}/Post/${postModel.postId}_${i}_load');

        await referenceStorageRef.putFile(imageFile);

        String downloadURL = await referenceStorageRef.getDownloadURL();

        postModel.imageUrlList[postModel.imageUrlList
            .indexOf(postModel.imageUrlList[i])] = downloadURL;
      }

      await postCollection.doc(postModel.postId).set(postModel.toJson());

      return postModel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPost() async {
    try {
      return postCollection.get().then((value) =>
          value.docs.map((e) => PostModel.fromJson(e.data())).toList());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPostCurrentUser({
    required String userId,
  }) async {
    try {
      final postsCurrentUser = await postCollection
          .where('userModel.uid', isEqualTo: userId)
          .get()
          .then((value) =>
              value.docs.map((e) => PostModel.fromJson(e.data())).toList());

      return postsCurrentUser;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<void> addOrRemoveLikeOnPost(
      {required PostModel postModel, required String currentUserId}) async {
    try {
      final postDoc = postCollection.doc(postModel.postId);
      final postData = await postDoc.get();

      final List<String> likeUsers =
          List<String>.from(postData.data()?['likeUsers'] ?? []);

      if (!likeUsers.contains(currentUserId)) {
        likeUsers.add(currentUserId);
      } else {
        likeUsers.remove(currentUserId);
      }
      postModel = postModel.copyWith(likeUsers: likeUsers);
      await postDoc.update(postModel.toJson());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<bool> isLiked(
      {required PostModel postModel, required String currentUserId}) async {
    final postDoc = postCollection.doc(postModel.postId);
    bool isLiked = false;
    try {
      final postData = await postDoc.get();

      final List<String> likeUsers =
          List<String>.from(postData.data()?['likeUsers'] ?? []);

      if (likeUsers.contains(currentUserId)) {
        isLiked = true;
      } else {
        isLiked = false;
      }
      postModel = postModel.copyWith(likeUsers: likeUsers);
      await postDoc.update(postModel.toJson());
      return isLiked;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<void> updatePost({required PostModel postModel}) async {
    try {
      await postCollection.doc(postModel.postId).update(postModel.toJson());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }
}
