import '../post_repository/models/post_model.dart';
import 'models/comment_model.dart';

abstract interface class AbstractCommentRepository {
  Future<CommentModel> createComment(
      {required String userId, required CommentModel comment});
  Future<List<CommentModel>> getCommentForPost({required PostModel post});
}
