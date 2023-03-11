import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';
import 'package:whatsapp_clone/features/home/presentation/widgets/contact_item.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget bodyBuilder() {
          if (state is GetAllUsersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAllUsersSuccessState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ContactItem(user: state.users[index]);
              },
              itemCount: state.users.length,
            );
          } else {
            return Container();
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Contact'),
            titleSpacing: 0,
          ),
          body: bodyBuilder(),
        );
      },
    );
  }
}