import 'package:flutter/material.dart';
import 'package:instx/ui/theme/const.dart';

final themeDart = ThemeData(
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // disabledBackgroundColor: const Color.fromARGB(255, 31, 45, 151),
      backgroundColor: AppConst.customButtonColor,
      // foregroundColor: Colors.white
    ),
  ),
  cardColor: AppConst.customButtonColor,
  appBarTheme:
      const AppBarTheme(backgroundColor: AppConst.appBarBackgroundColor),
  scaffoldBackgroundColor: AppConst.scaffoldBackgroundColor,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: AppConst.kBodySmall,
    ),
    bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: AppConst.kBodyMedium,
        fontWeight: FontWeight.bold),
  ),
);

final themeLight = ThemeData(
  brightness: Brightness.light,
);
