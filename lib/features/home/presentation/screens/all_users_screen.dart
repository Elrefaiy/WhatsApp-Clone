import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';
import 'package:whatsapp_clone/features/home/presentation/widgets/contact_item.dart';

import '../../../../core/utils/app_colors.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget contactsBuilder() {
          if (state is GetAllUsersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ContactItem(
                  user: HomeCubit.get(context).allUsers[index],
                );
              },
              itemCount: HomeCubit.get(context).allUsers.length,
            );
          }
        }

        Widget body() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.c2(),
                        child: const Icon(
                          Icons.people_alt,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'New group',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.c2(),
                        child: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'New contact',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Contacts on WhatsApp',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(height: 10),
                contactsBuilder(),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Invite to WhatsApp',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blueGrey[100],
                        child: Icon(
                          Icons.share,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Share invite link',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blueGrey[100],
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Contacts help',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Contact'),
                if (state is GetAllUsersSuccessState)
                  Text(
                    '${HomeCubit.get(context).allUsers.length} Contacts',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
            titleSpacing: 0,
          ),
          body: body(),
        );
      },
    );
  }
}
