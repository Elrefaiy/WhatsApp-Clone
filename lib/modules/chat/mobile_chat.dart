import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/shared/components/components.dart';

class MobileChats extends StatelessWidget {
  const MobileChats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) => chatItem(context),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: 9,
        );
      },
    );
  }
}
