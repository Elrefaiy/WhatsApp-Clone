import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/widgets/setting_widget.dart';

class MobileSettingsScreen extends StatelessWidget {
  const MobileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is LogoutLoadingState) {
          AppConstants.showLoadingDialog(context);
        } else if (state is LogoutSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        } else if (state is LogoutErrorState) {
          AppConstants.showSnackBar(
            context: context,
            content: state.message,
          );
        }
      },
      builder: (context, state) {
        final user = AuthenticationCubit.get(context).currentUser;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text(
              'Settings',
            ),
          ),
          body: Column(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const MobileProfile(),
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'Profile',
                        child: AppConstants.userImage(
                          radius: 35,
                          image: user.image,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.about,
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(.7),
                height: 4,
              ),
              SettingWidget(
                onTap: () {
                  SettingsCubit.get(context).changeMode();
                },
                icon: Icons.brightness_6,
                label: 'Theme',
                hint: SettingsCubit.get(context).isDark ? 'Dark' : 'Light',
              ),
              SettingWidget(
                onTap: () {
                  SettingsCubit.get(context).logout();
                },
                icon: Icons.logout,
                label: 'Change number',
                hint: 'Logout from account, new phone number.',
              ),
              SettingWidget(
                onTap: () {},
                icon: Icons.delete,
                label: 'Delete my account',
                hint: 'Remove my account permanently.',
              ),
              SettingWidget(
                onTap: () {},
                icon: Icons.info_outline,
                label: 'Help',
                hint: 'Help center, contact us, privacy policy.',
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'from',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.meta,
                    color: SettingsCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                    size: 16,
                  ),
                  Text(
                    ' Meta',
                    style: TextStyle(
                      fontSize: 18,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
