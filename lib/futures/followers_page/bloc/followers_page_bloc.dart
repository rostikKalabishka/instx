import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';

part 'followers_page_event.dart';
part 'followers_page_state.dart';

class FollowersPageBloc extends Bloc<FollowersPageEvent, FollowersPageState> {
  final AbstractAuthRepository _abstractAuthRepository;
  Timer? searchDebounce;
  FollowersPageBloc({required AbstractAuthRepository abstractAuthRepository})
      : _abstractAuthRepository = abstractAuthRepository,
        super(const FollowersPageState()) {
    on<FollowersPageEvent>((event, emit) async {
      if (event is SearchFollowersEvent) {
        await _search(event, emit);
      } else if (event is LoadAllFollowers) {
        await _loadFollowers(event, emit);
      }
    }, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  Future<void> _search(SearchFollowersEvent event, emit) async {
    try {
      searchDebounce?.cancel();

      final completer = Completer<void>();
      final userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);
      searchDebounce = Timer(const Duration(milliseconds: 200), () async {
        final userModelList = await _abstractAuthRepository.searchUser(
            text: event.text, userModel: userModel);

        emit(state.copyWith(userModelList: userModelList));
        completer.complete();
      });

      await completer.future;
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }

  Future<void> _loadFollowers(LoadAllFollowers event, emit) async {
    try {
      final userModel =
          await _abstractAuthRepository.getUserById(userId: event.userId);

      final userModelList = userModel.followers;
      emit(state.copyWith(
          statusPage: StatusPage.loaded, userModelList: userModelList));
    } catch (e) {
      emit(state.copyWith(statusPage: StatusPage.failure, error: e));
    }
  }
}
