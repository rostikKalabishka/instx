import 'dart:async';

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
      } else if (event is LogOut) {
        await logOut(event, emit);
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

  Future<void> logOut(LogOut event, emit) async {
    final autoRouter = AutoRouter.of(event.context);
    try {
      await _abstractAuthRepository.signOut();
      emit(state.copyWith(status: UserAuthStatus.unauth));
      autoRouter.pushAndPopUntil(const LoaderRoute(),
          predicate: (route) => false);
    } catch (e) {
      emit(state.copyWith(
        error: e,
      ));
    }
  }

  Future<void> signInWithApple(AuthWithApple event, emit) async {
    emit(state.copyWith(status: UserAuthStatus.unknown));
    try {
      await _abstractAuthRepository.signInWithApple();

      emit(state.copyWith(status: UserAuthStatus.auth));
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
    }
  }

  Future<void> signInWithGoogle(AuthWithGoogle event, emit) async {
    final autoRoute = AutoRouter.of(event.context);
    emit(state.copyWith(
      status: UserAuthStatus.unauth,
    ));
    try {
      await _abstractAuthRepository.signInWithGoogle();

      emit(state.copyWith(
        status: UserAuthStatus.auth,
      ));

      autoRoute.push(
        const LoaderRoute(),
      );
    } catch (e) {
      emit(state.copyWith(error: e, status: UserAuthStatus.unauth));
    }
  }

  Future<void> authenticationUserChanged(
      AuthenticationUserChanged event, emit) async {
    final user = event.user;

    try {
      if (user != null) {
        emit(state.copyWith(status: UserAuthStatus.auth, userId: user.uid));
      } else {
        emit(state.copyWith(
          status: UserAuthStatus.unauth,
        ));
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
