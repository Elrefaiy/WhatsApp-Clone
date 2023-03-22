import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../widgets/chat_item.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SendTextMessageSuccessState) {
          HomeCubit.get(context).getAllChats();
        }
      },
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ChatWidget(
            contact: HomeCubit.get(context).allContacts[index],
          ),
          itemCount: HomeCubit.get(context).allContacts.length,
        );
      },
    );
  }
}
