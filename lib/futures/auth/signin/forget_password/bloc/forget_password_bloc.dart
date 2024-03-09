import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AbstractAuthRepository _abstractAuthRepository;
  ForgetPasswordBloc(AbstractAuthRepository abstractAuthRepository)
      : _abstractAuthRepository = abstractAuthRepository,
        super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) async {
      await _abstractAuthRepository.forgotPassword(email: event.email);
    });
  }
}
