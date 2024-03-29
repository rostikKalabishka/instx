import 'package:auto_route/auto_route.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/router/router.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AbstractAuthRepository abstractAuthRepository})
      : _abstractAuthRepository = abstractAuthRepository,
        super(const SignInState()) {
    on<SignInEvent>((event, emit) async {
      if (event is NavigateToForgetPasswordPageEvent) {
        navigateToForgetPasswordPage(event, emit);
      } else if (event is LoginEvent) {
        await login(event, emit);
      }
    });
  }
  final AbstractAuthRepository _abstractAuthRepository;

  Future<void> login(LoginEvent event, emit) async {
    final autoRouter = AutoRouter.of(event.context);
    emit(state.copyWith(status: UserAuthStatus.unauth));
    try {
      await _abstractAuthRepository.login(
          password: event.password, email: event.email);
      emit(state.copyWith(status: UserAuthStatus.auth));
      autoRouter.pushAndPopUntil(const LoaderRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
    }
  }

  void navigateToForgetPasswordPage(
      NavigateToForgetPasswordPageEvent event, emit) {
    final autoRouter = AutoRouter.of(event.context);
    try {
      autoRouter.push(const ForgetPasswordRoute());
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
