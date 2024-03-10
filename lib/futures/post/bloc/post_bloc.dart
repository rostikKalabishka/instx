import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/models.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AbstractPostRepository _abstractPostRepository;
  final AbstractAuthRepository _abstractAuthRepository;
  PostBloc(AbstractPostRepository abstractPostRepository,
      AbstractAuthRepository abstractAuthRepository)
      : _abstractPostRepository = abstractPostRepository,
        _abstractAuthRepository = abstractAuthRepository,
        super(const PostState()) {
    on<PostEvent>((event, emit) async {
      if (event is CreatePostEvent) {
        await _createPost(event, emit);
      }
    });
  }
  Future<void> _createPost(CreatePostEvent event, emit) async {
    try {
      final userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);

      PostModel postModel = PostModel.emptyPost.copyWith(
          userModel: userModel, post: event.post, imageUrl: event.imageUrl);
      await _abstractPostRepository.createPost(postModel);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
