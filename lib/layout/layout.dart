import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/layout/mobile_layout.dart';
import 'package:whatsapp_clone/layout/web_layout.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth <= 800) {
              return const MobileLayout();
            } else {
              return WebLayout(
                model: AppCubit.get(context).users[0],
              );
            }
          },
        );
      },
    );
  }
}
