import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/screens/mobile_settings.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'WhatsApp',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 24,
                      color: SettingsCubit.get(context).isDark
                          ? AppColors.c5()
                          : Colors.white,
                    ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: SettingsCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: SettingsCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: SettingsCubit.get(context).isDark
                        ? AppColors.c5()
                        : Colors.white,
                  ),
                  color: SettingsCubit.get(context).isDark
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
                                      color: SettingsCubit.get(context).isDark
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
                unselectedLabelColor: SettingsCubit.get(context).isDark
                    ? AppColors.c5()
                    : Colors.white70,
                labelColor: SettingsCubit.get(context).isDark
                    ? AppColors.c2()
                    : Colors.white,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: SettingsCubit.get(context).isDark
                          ? AppColors.c2()
                          : Colors.white,
                      width: 4,
                    ),
                  ),
                ),
                onTap: (index) {
                  // SettingsCubit.get(context).changeCurrentIndex(index);
                  // if (index == 0) {
                  //   SettingsCubit.get(context).getUsers();
                  // } else if (index == 1) {
                  //   SettingsCubit.get(context).getStatus();
                  // }
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
              children: [
                Center(
                  child: Text('Chats'),
                ),
                Center(
                  child: Text('Status'),
                ),
                Center(
                  child: Text('Calls'),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                HomeCubit.get(context).getAllUsers();
                Navigator.pushNamed(
                  context,
                  Routes.contacts,
                );
              },
              child: const Icon(Icons.message),
            ),
          ),
        );
      },
    );
  }
}

// Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SettingsCubit.get(context).currentIndex == 1
//                     ? FloatingActionButton(
//                         heroTag: null,
//                         mini: true,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const AddTextStatusScreen(),
//                             ),
//                           );
//                         },
//                         backgroundColor: Colors.grey[100],
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.blueGrey,
//                         ),
//                       )
//                     : Container(
//                         width: 0,
//                       ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 FloatingActionButton(
//                   heroTag: null,
//                   onPressed: () {},
//                   backgroundColor: AppColors.c2(),
//                   child: Icon(
//                     AppCubit.get(context).currentIndex == 0
//                         ? Icons.chat
//                         : AppCubit.get(context).currentIndex == 1
//                             ? Icons.camera_alt
//                             : Icons.call,
//                   ),
//                 ),
//               ],
//             ),