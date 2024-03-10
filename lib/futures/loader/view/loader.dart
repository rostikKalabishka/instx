import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instx/futures/auth/bloc/auth_bloc.dart';

import 'package:instx/router/router.dart';

@RoutePage()
class LoaderPage extends StatefulWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigateTo(context, state);
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

void navigateTo(BuildContext context, AuthState state) {
  if (state.status == UserAuthStatus.auth && state.userId.isNotEmpty) {
    const loadNextPage = HomeRoute();
    AutoRouter.of(context).pushAndPopUntil(
        loadNextPage as PageRouteInfo<dynamic>,
        predicate: (route) => false);
  } else {
    AutoRouter.of(context).pushAndPopUntil(
        const AuthRoute() as PageRouteInfo<dynamic>,
        predicate: (route) => false);
  }
}
