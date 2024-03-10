import 'models/models.dart';

abstract interface class AbstractPostRepository {
  Future<PostModel> createPost(PostModel postModel);

  Future<List<PostModel>> getAllPost();

  Future<List<PostModel>> getAllPostCurrentUser({required String userId});
}
