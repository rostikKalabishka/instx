import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instx/router/router.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInEvent>((event, emit) async {
      if (event is NavigateToForgetPasswordPageEvent) {
        navigateToForgetPasswordPage(event, emit);
      }
    });
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