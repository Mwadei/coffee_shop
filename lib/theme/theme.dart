import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.grey,
      secondary: Colors.black,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF212325),
      primary: Color.fromARGB(255, 50, 54, 56),
      secondary: Colors.white,
    ));
