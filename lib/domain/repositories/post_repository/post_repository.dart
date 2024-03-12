import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository implements AbstractPostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');
  @override
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
  Future<List<PostModel>> getAllPostCurrentUser(
      {required String userId}) async {
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
}
