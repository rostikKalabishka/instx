import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/domain/repositories/comment_repository/comment_repository.dart';
import 'package:instx/domain/repositories/post_repository/post_repository.dart';
import 'package:instx/domain/repositories/user_repository/user_repository.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';

import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/futures/auth/registration/bloc/registration_bloc.dart';
import 'package:instx/futures/auth/signin/bloc/sign_in_bloc.dart';
import 'package:instx/futures/auth/signin/forget_password/bloc/forget_password_bloc.dart';
import 'package:instx/futures/post/bloc/post_bloc.dart';

import '../../futures/auth/auth_page.dart';
import '../../futures/auth/signin/forget_password/forget_password.dart';
import '../../futures/profile/bloc/profile_bloc.dart';

class ProvideBloc extends StatefulWidget {
  const ProvideBloc({Key? key, required this.child, required this.dio})
      : super(key: key);
  final Widget child;
  final Dio dio;
  @override
  State<ProvideBloc> createState() => _ProvideBlocState();
}

class _ProvideBlocState extends State<ProvideBloc> {
  final UserRepository userRepository = UserRepository();
  final PostRepository postRepository = PostRepository();
  final CommentRepository commentRepository = CommentRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => AuthBloc(
                abstractAuthRepository: userRepository,
              ),
          child: const AuthPage()),
      BlocProvider(
          create: (_) => SignInBloc(abstractAuthRepository: userRepository),
          child: const SignInPage()),
      BlocProvider(
          create: (_) =>
              RegistrationBloc(abstractAuthRepository: userRepository),
          child: const RegistrationPage()),
      BlocProvider(
          create: (_) => ForgetPasswordBloc(userRepository),
          child: const ForgetPasswordPage()),
      BlocProvider(create: (_) => PostBloc(postRepository, userRepository)),
      BlocProvider(create: (_) => AllPostBloc(postRepository)),
      BlocProvider(
          create: (_) => ProfileBloc(
              abstractAuthRepository: userRepository,
              abstractPostRepository: postRepository))
    ], child: widget.child);
  }
}
