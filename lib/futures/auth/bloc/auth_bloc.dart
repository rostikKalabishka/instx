import 'package:auto_route/auto_route.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/router/router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AbstractAuthRepository abstractAuthRepository})
      : _abstractAuthRepository = abstractAuthRepository,
        super(const AuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is NavigateToSignIn) {
        navigateToSignInPage(event, emit);
      } else if (event is NavigateToRegistration) {
        navigateToRegistrationPage(event, emit);
      } else if (event is SignInWithApple) {
      } else if (event is SignInWithGoogle) {}
    });
  }

  final AbstractAuthRepository _abstractAuthRepository;

  void navigateToSignInPage(NavigateToSignIn event, emit) {
    final autoRouter = AutoRouter.of(event.context);

    try {
      autoRouter.push(const SignInRoute());
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void navigateToRegistrationPage(NavigateToRegistration event, emit) {
    final autoRouter = AutoRouter.of(event.context);

    try {
      autoRouter.push(const RegistrationRoute());
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
