import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/login/login.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(context).size.width >= 560 ? 1.3 : 1,
          ),
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
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
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 30,
                                  ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            AppCubit.get(context).isDark
                                ? 'assets/images/welcome-dark.jpg'
                                : 'assets/images/welcome-light.jpg',
                          ),
                          radius:
                              MediaQuery.of(context).size.width.toInt() >= 560
                                  ? 190
                                  : 140,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.blue,
                                    ),
                              ),
                              TextSpan(
                                text: ' Tap "Agree and continue" to accept the',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              TextSpan(
                                text: ' Terms of Service.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: c2(),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
