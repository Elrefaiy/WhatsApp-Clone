import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';

class WhatsApp extends StatelessWidget {
  final Widget startWidget;
  const WhatsApp({required this.startWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUser()
        ..getUsers()
        ..getStatus(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: AppRoutes.onGeneratedRoute,
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).isDark ? darkTheme() : lightTheme(),
            home: startWidget,
          );
        },
      ),
    );
  }
}
