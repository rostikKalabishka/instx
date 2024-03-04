import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:instx/domain/factory/provide_bloc.dart';

import 'package:instx/ui/theme/theme.dart';

import 'router/router.dart';

class InstxApp extends StatefulWidget {
  const InstxApp({super.key, required this.dio});
  final Dio dio;
  @override
  State<InstxApp> createState() => _InstxAppState();
}

class _InstxAppState extends State<InstxApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProvideBloc(
      dio: widget.dio,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: themeDark,
        darkTheme: themeDark,
        themeMode: ThemeMode.dark,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
