import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/domain/repositories/user_repository/models/user.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AbstractAuthRepository _abstractAuthRepository;
  RegistrationBloc({
    required AbstractAuthRepository abstractAuthRepository,
  })  : _abstractAuthRepository = abstractAuthRepository,
        super(const RegistrationState()) {
    on<RegistrationEvent>((event, emit) async {
      // final autoRouter = AutoRouter.of(event.context);
      emit(state.copyWith(status: UserAuthStatus.process));
      try {
        final UserModel userDate = UserModel.userEmpty.copyWith(
            createAt: DateTime.now().toString(),
            email: event.email,
            username: event.userName);

        final user = await _abstractAuthRepository.registration(
            userDate, event.password);
        final currentUser = await _abstractAuthRepository.user.first;
        if (currentUser != null) {
          emit(state.copyWith(status: UserAuthStatus.success));

          await _abstractAuthRepository.setUserData(user);
        }
      } catch (e) {
        emit(state.copyWith(error: e, status: UserAuthStatus.failure));
      }
    });
  }
}
