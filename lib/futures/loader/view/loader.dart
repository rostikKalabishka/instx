import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instx/futures/auth/bloc/auth_bloc.dart';

import 'package:instx/router/router.dart';

@RoutePage()
class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          navigateTo(context, state);
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ));
  }
}

void navigateTo(BuildContext context, AuthState state) {
  final loadNextPage = state.status == UserAuthStatus.auth
      ? HomeRoute(userId: state.userId)
      : const AuthRoute();
  AutoRouter.of(context).pushAndPopUntil(loadNextPage as PageRouteInfo<dynamic>,
      predicate: (route) => false);
}
