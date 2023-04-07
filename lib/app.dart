import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/app_routes.dart';
import 'features/authentication/presentation/cubit/authentication_cubit.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'injection_container.dart' as di;

class WhatsApp extends StatelessWidget {
  final Widget startWidget;
  final bool mode;
  const WhatsApp({required this.startWidget, required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthenticationCubit>()..getCurrentUser(),
        ),
        BlocProvider(
          create: (context) => di.sl<HomeCubit>()
            ..getStatus(context)
            ..getAllChats(),
        ),
        BlocProvider(
          create: (context) => di.sl<SettingsCubit>()..changeMode(mode),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: AppRoutes.onGeneratedRoute,
            debugShowCheckedModeBanner: false,
            theme:
                SettingsCubit.get(context).isDark ? darkTheme() : lightTheme(),
            home: startWidget,
          );
        },
      ),
    );
  }
}
