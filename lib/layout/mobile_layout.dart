import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/chat/mobile_chat.dart';
import 'package:whatsapp_clone/modules/status/mobile_status.dart';
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
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                onTap: (index) {
                  AppCubit.get(context).changeCurrentIndex(index);
                },
                tabs: const [
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
              physics: NeverScrollableScrollPhysics(),
              children: [
                MobileChats(),
                MobileStatus(),
                Center(
                  child: Text('Calls'),
                ),
              ],
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppCubit.get(context).currentIndex == 1
                    ? FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: () {},
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey[600],
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {},
                  backgroundColor: c2(),
                  child: Icon(
                    AppCubit.get(context).currentIndex == 0
                        ? Icons.message
                        : AppCubit.get(context).currentIndex == 1
                            ? Icons.camera_alt
                            : Icons.call,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
