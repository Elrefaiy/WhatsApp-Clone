import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'cubit/app_cubit.dart';
import 'injection_container.dart' as di;

class WhatsApp extends StatelessWidget {
  final Widget startWidget;
  const WhatsApp({required this.startWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
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
