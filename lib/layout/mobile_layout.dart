import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/chat/mobile_chat.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'WhatsApp',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                    ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                tabs: [
                  Tab(
                    child: Text(
                      'CHATS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'STATUS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'CALLLS',
                    ),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                MobileChatsScreen(),
                Center(
                  child: Text('Status'),
                ),
                Center(
                  child: Text('Calls'),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: c2(),
              child: const Icon(
                Icons.message,
              ),
            ),
          ),
        );
      },
    );
  }
}
