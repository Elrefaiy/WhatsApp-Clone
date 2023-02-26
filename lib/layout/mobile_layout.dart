import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/chat/mobile_chat.dart';
import 'package:whatsapp_clone/modules/settings/mobile_settings.dart';
import 'package:whatsapp_clone/modules/status/add_status/add_text_status.dart';
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
                      color: AppCubit.get(context).isDark
                          ? AppColors.c5()
                          : Colors.white,
                    ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: AppCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                  color: AppCubit.get(context).isDark
                      ? const Color.fromARGB(255, 50, 65, 73)
                      : Colors.grey[100],
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MobileSettingsScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            'Settings',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.grey[800],
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                unselectedLabelColor: AppCubit.get(context).isDark
                    ? AppColors.c5()
                    : Colors.white70,
                labelColor: AppCubit.get(context).isDark
                    ? AppColors.c2()
                    : Colors.white,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppCubit.get(context).isDark
                          ? AppColors.c2()
                          : Colors.white,
                      width: 4,
                    ),
                  ),
                ),
                onTap: (index) {
                  AppCubit.get(context).changeCurrentIndex(index);
                  if (index == 0) {
                    AppCubit.get(context).getUsers();
                  } else if (index == 1) {
                    AppCubit.get(context).getStatus();
                  }
                },
                tabs: const [
                  Tab(
                    child: Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Calls',
                      style: TextStyle(
                        fontSize: 16,
                      ),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddTextStatusScreen(),
                            ),
                          );
                        },
                        backgroundColor: Colors.grey[100],
                        child: const Icon(
                          Icons.edit,
                          color: Colors.blueGrey,
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
                  backgroundColor: AppColors.c2(),
                  child: Icon(
                    AppCubit.get(context).currentIndex == 0
                        ? Icons.chat
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
