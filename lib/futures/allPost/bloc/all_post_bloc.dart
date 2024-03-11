import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instx/domain/repositories/post_repository/abstract_post_repository.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final AbstractPostRepository _abstractPostRepository;
  AllPostBloc(AbstractPostRepository abstractPostRepository)
      : _abstractPostRepository = abstractPostRepository,
        super(const AllPostState()) {
    on<AllPostEvent>((event, emit) async {
      if (event is AllPostLoaded) {
        await _allPostLoaded(event, emit);
      }
    });
  }

  Future<void> _allPostLoaded(AllPostLoaded event, emit) async {
    if (state.status != StatusPage.loaded) {
      emit(state.copyWith(status: StatusPage.loading));
    }

    try {
      final allPost = await _abstractPostRepository.getAllPost();
      emit(state.copyWith(status: StatusPage.loaded, postList: allPost));
    } catch (e) {
      emit(state.copyWith(status: StatusPage.failure, error: e));
    }
  }
}
