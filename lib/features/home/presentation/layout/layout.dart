import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/authentication/data/models/user_model.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';
import 'package:whatsapp_clone/features/home/presentation/layout/mobile_layout.dart';
import 'package:whatsapp_clone/features/home/presentation/layout/web_layout.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (kIsWeb) {
          return const WebLayout(
            model: UserModel(
              name: 'test user',
              phone: '01111111111',
              image: 'image',
              about: 'about',
              uId: 'testuid',
            ),
          );
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
