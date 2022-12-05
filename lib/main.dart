import 'package:flutter/material.dart';
import 'package:whatsapp_clone/modules/home/home.dart';
import 'package:whatsapp_clone/modules/welcome/welcome.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: const WelcomeScreen(),
    );
  }
}
