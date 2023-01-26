import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/layout/layout.dart';
import 'package:whatsapp_clone/modules/welcome/welcome.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';
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
  runApp(MyApp(startWidget: widget));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({
    required this.startWidget,
    super.key,
  });

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
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).isDark ? darkTheme() : lightTheme(),
            home: startWidget,
          );
        },
      ),
    );
  }
}
