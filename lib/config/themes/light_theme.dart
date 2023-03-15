import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      color: AppColors.c1(),
      titleSpacing: 20,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: AppColors.c1(),
        fontSize: 24,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      headline2: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      headline3: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText1: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText2: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
