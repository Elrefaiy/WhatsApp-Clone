import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Application Themes
ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
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
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
    );

// Application Color Pallet
Color c1() => const Color(0xff075e54);
Color c2() => const Color(0xff128c7e);
Color c3() => const Color(0xff25d366);
Color c4() => const Color(0xffdcf8c6);
Color c5() => const Color(0xffece5dd);
Color c6() => const Color(0xff131A22);
