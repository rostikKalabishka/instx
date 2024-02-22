import 'package:flutter/material.dart';

import 'package:instx/ui/theme/theme.dart';

import 'router/router.dart';

class InstxApp extends StatefulWidget {
  const InstxApp({super.key});

  @override
  State<InstxApp> createState() => _InstxAppState();
}

class _InstxAppState extends State<InstxApp> {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter.config(),
    );
  }
}
