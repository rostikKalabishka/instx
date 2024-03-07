import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/user_repository/abstract_user_repository.dart';
import 'package:instx/router/router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AbstractAuthRepository abstractAuthRepository,
  })  : _abstractAuthRepository = abstractAuthRepository,
        super(const AuthState()) {
    _userSubscription = _abstractAuthRepository.user.listen((user) {
      // log(user.toString());
      add(AuthenticationUserChanged(user));
    });
    on<AuthEvent>((event, emit) async {
      if (event is NavigateToSignIn) {
        navigateToSignInPage(event, emit);
      } else if (event is NavigateToRegistration) {
        navigateToRegistrationPage(event, emit);
      } else if (event is AuthWithApple) {
        await signInWithApple(event, emit);
      } else if (event is AuthWithGoogle) {
        await signInWithGoogle(event, emit);
      } else if (event is AuthenticationUserChanged) {
        await authenticationUserChanged(event, emit);
      }
    });
  }

  final AbstractAuthRepository _abstractAuthRepository;

  late final StreamSubscription<User?> _userSubscription;

  void navigateToSignInPage(NavigateToSignIn event, emit) {
    final autoRouter = AutoRouter.of(event.context);

    try {
      autoRouter.push(const SignInRoute());
    } catch (e) {
      emit(state.copyWith(
        error: e,
      ));
    }
  }

  Future<void> signInWithApple(AuthWithApple event, emit) async {
    emit(state.copyWith(status: UserAuthStatus.unknown));
    try {
      final boba = _abstractAuthRepository.signInWithApple();
      print(boba);
      emit(state.copyWith(status: UserAuthStatus.auth));
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
    }
  }

  Future<void> signInWithGoogle(AuthWithGoogle event, emit) async {
    emit(state.copyWith(status: UserAuthStatus.unknown));
    try {
      // final boba =
      await _abstractAuthRepository.signInWithGoogle();

      emit(state.copyWith(status: UserAuthStatus.auth));
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
    }
  }

  Future<void> authenticationUserChanged(
      AuthenticationUserChanged event, emit) async {
    final user = event.user;

    try {
      if (user != null) {
        emit(state.copyWith(status: UserAuthStatus.auth));
      }
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
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

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
