import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/shared/components/components.dart';

class MobileChats extends StatelessWidget {
  const MobileChats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List users = AppCubit.get(context).users;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => chatItem(
                  context,
                  users[index],
                ),
                itemCount: users.length,
              ),
              Divider(
                color: Colors.blueGrey.withOpacity(.3),
                thickness: 1,
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.lock,
                    size: 14,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Your personal messages are ',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 11,
                                  ),
                        ),
                        TextSpan(
                          text: 'end-to-end encrypted',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColors.c2(),
                                    fontSize: 11,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        );
      },
    );
  }
}
