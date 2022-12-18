import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String token = '';

// Application Themes
ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
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
        bodyText1: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

ThemeData darkTheme() => ThemeData(
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: c3(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        color: c4(),
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
        ),
      ),
    );

// Application Color Pallet
Color c1() => const Color(0xff008069);
Color c2() => const Color(0xff00A884);

Color c3() => const Color(0xff111B21);
Color c4() => const Color(0xff233138);
Color c5() => const Color(0xff8696A0);
