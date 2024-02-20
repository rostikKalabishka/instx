import 'package:flutter/material.dart';
import 'package:instx/futures/auth/view/auth_page.dart';

import 'package:instx/ui/theme/theme.dart';

class InstxApp extends StatelessWidget {
  const InstxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeLight,
      darkTheme: themeDart,
      themeMode: ThemeMode.dark,
      home: const AuthPage(),
    );
  }
}
