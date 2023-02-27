import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/layout/layout.dart';
import 'package:whatsapp_clone/modules/welcome/welcome.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';
import 'app.dart';
import 'cubit/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  token = CacheHelper.getData(key: 'token') ?? '';
  Widget widget = const WelcomeScreen();
  if (token != '') {
    widget = const Layout();
  }
  runApp(WhatsApp(startWidget: widget));
}
