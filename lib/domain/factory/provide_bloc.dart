import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/futures/auth/registration/bloc/registration_bloc.dart';
import 'package:instx/futures/auth/signin/bloc/sign_in_bloc.dart';
import 'package:instx/futures/auth/signin/forget_password/bloc/forget_password_bloc.dart';

import '../../futures/auth/auth_page.dart';
import '../../futures/auth/signin/forget_password/forget_password.dart';

class ProvideBloc extends StatefulWidget {
  const ProvideBloc({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<ProvideBloc> createState() => _ProvideBlocState();
}

class _ProvideBlocState extends State<ProvideBloc> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => AuthBloc(), child: const AuthPage()),
      BlocProvider(create: (_) => SignInBloc(), child: const SignInPage()),
      BlocProvider(
          create: (_) => RegistrationBloc(), child: const RegistrationPage()),
      BlocProvider(
          create: (_) => ForgetPasswordBloc(),
          child: const ForgetPasswordPage())
    ], child: widget.child);
  }
}
