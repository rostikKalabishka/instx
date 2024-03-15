import 'models/models.dart';

abstract interface class AbstractPostRepository {
  Future<PostModel> createPost(PostModel postModel);

  Future<List<PostModel>> getAllPost();

  Future<List<PostModel>> getAllPostCurrentUser({required String userId});

  Future<void> addOrRemoveLikeOnPost(
      {required PostModel postModel, required String currentUserId});

  Future<bool> isLiked(
      {required PostModel postModel, required String currentUserId});

  Future<void> updatePost({
    required PostModel postModel,
  });
}
