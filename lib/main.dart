import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'core/utils/app_strings.dart';
import 'features/authentication/presentation/screens/welcome.dart';
import 'features/home/presentation/layout/layout.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String token = di.sl<SharedPreferences>().getString(AppStrings.token) ?? '';
  bool mode = di.sl<SharedPreferences>().getBool(AppStrings.isDark) ?? false;
  Widget widget = const WelcomeScreen();
  if (token != '') {
    widget = const Layout();
  }
  runApp(
    WhatsApp(
      startWidget: widget,
      mode: mode,
    ),
  );
}
