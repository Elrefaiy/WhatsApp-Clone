import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';
import 'package:whatsapp_clone/features/home/presentation/widgets/floating_action_boutton.dart';
import 'package:whatsapp_clone/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/screens/mobile_settings.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      HomeCubit.get(context).changeIndex(controller.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: NestedScrollView(
            body: TabBarView(
              controller: controller,
              children: const <Widget>[
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
            headerSliverBuilder: (BuildContext context, bool isScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.headline3,
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
                          ? Colors.blueGrey[800]
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
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
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    controller: controller,
                    indicatorColor: SettingsCubit.get(context).isDark
                        ? AppColors.c2()
                        : Colors.white,
                    indicatorWeight: 4,
                    tabs: <Tab>[
                      Tab(
                        child: Text(
                          'Chats',
                          style: TextStyle(
                            fontSize: 15,
                            color: HomeCubit.get(context).currentIndex == 0
                                ? SettingsCubit.get(context).isDark
                                    ? AppColors.c2()
                                    : Colors.white
                                : Colors.white.withOpacity(.6),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 15,
                            color: HomeCubit.get(context).currentIndex == 1
                                ? SettingsCubit.get(context).isDark
                                    ? AppColors.c2()
                                    : Colors.white
                                : Colors.white.withOpacity(.6),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Calls',
                          style: TextStyle(
                            fontSize: 15,
                            color: HomeCubit.get(context).currentIndex == 2
                                ? SettingsCubit.get(context).isDark
                                    ? AppColors.c2()
                                    : Colors.white
                                : Colors.white.withOpacity(.6),
                          ),
                        ),
                      ),
                    ],
                    // controller: _tabController,
                  ),
                ),
              ];
            },
          ),
          floatingActionButton: FAB(
            index: HomeCubit.get(context).currentIndex,
          ),
        );
      },
    );
  }
}
