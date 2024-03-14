import 'package:instx/domain/repositories/comment_repository/abstract_comment_repository.dart';
import 'package:instx/domain/repositories/comment_repository/models/comment_model.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

class CommentRepository implements AbstractCommentRepository {
  @override
  Future<CommentModel> createComment(
      {required PostModel post,
      required String userId,
      required String comment}) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<List<CommentModel>> getCommentForPost({required PostModel post}) {
    // TODO: implement getCommentForPost
    throw UnimplementedError();
  }
}
