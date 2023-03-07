import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/home/presentation/layout/layout.dart';
import 'package:whatsapp_clone/features/authentication/presentation/screens/welcome.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await di.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String token = di.sl<SharedPreferences>().getString(AppStrings.token) ?? '';
  Widget widget = const WelcomeScreen();
  if (token != '') {
    widget = const Layout();
  }
  runApp(WhatsApp(startWidget: widget));
}
