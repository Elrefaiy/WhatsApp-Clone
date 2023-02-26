import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: AppColors.c3(),
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      color: AppColors.c4(),
      titleSpacing: 20,
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.w500,
      ),
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.blueGrey[400],
        fontSize: 13,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
