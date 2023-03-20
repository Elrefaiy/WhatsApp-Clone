import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/media_query.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bodyBuilder() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 50,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to WhatsApp',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 30,
                      ),
                ),
                const SizedBox(
                  height: 120,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    SettingsCubit.get(context).isDark
                        ? 'assets/images/welcome-dark.jpg'
                        : 'assets/images/welcome-light.jpg',
                  ),
                  radius: context.width.toInt() >= 560 ? 190 : 140,
                  backgroundColor: Colors.white.withOpacity(0),
                ),
                const SizedBox(
                  height: 120,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Read our',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: ' Privacy Policy.',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                      TextSpan(
                        text: ' Tap "Agree and continue" to accept the',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: ' Terms of Service.',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.login,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.c2(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'AGREE AND CONTINUE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MediaQuery(
      data: AppConstants.mediaQueryData(context),
      child: SafeArea(
        child: Scaffold(
          body: bodyBuilder(),
        ),
      ),
    );
  }
}
