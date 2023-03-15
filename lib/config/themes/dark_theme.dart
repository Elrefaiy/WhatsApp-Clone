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
        fontSize: 24,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      headline3: TextStyle(
        color: AppColors.c5(),
        fontSize: 24,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText1: const TextStyle(
        color: Colors.white,
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
