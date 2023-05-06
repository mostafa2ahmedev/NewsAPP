import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class Themes {
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: lightScaffoldColor,
    ),
    scaffoldBackgroundColor: lightScaffoldColor,
    primaryColor: lightCardColor,
    hintColor: Colors.grey.shade700,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue,
    ),
    cardColor: lightCardColor,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: darkScaffoldColor,
    ),
    scaffoldBackgroundColor: darkScaffoldColor,
    primaryColor: darkCardColor,
    hintColor: Colors.grey.shade400,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue,
    ),
    cardColor: darkCardColor,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
