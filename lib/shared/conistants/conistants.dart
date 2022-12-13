import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String token = '';

// Application Themes
ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        color: c1(),
        titleSpacing: 20,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: c1(),
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        headline2: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          color: Colors.grey[800],
          fontSize: 13,
        ),
      ),
    );

ThemeData darkTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: c3(),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        color: c3(),
        titleSpacing: 20,
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        headline2: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          color: Colors.grey[300],
          fontSize: 13,
        ),
      ),
    );

// Application Color Pallet

//light
Color c1() => const Color(0xff008069);
Color c2() => const Color(0xff128c7e);

//dark
Color c3() => const Color(0xff131A22);
Color c4() => Color.fromARGB(255, 25, 34, 44);
