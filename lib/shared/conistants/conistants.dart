import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Application Themes
ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: c1(),
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
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    );

ThemeData darkTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: c3(),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        color: Color(0xff25d366),
        titleSpacing: 20,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: c2(),
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
    );

// Application Color Pallet
Color c1() => const Color(0xff008069);
Color c2() => const Color(0xff128c7e);
Color c3() => const Color(0xff131A22);
