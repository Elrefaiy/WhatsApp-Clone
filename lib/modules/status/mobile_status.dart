import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/status.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class MobileStatus extends StatelessWidget {
  const MobileStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<UserModel> users = AppCubit.get(context).users;
        Map<String, List<StatusModel>> status = AppCubit.get(context).status;
        List<UserModel> usersWithStatus = [];
        for (var element in users) {
          if (status.containsKey(element.uId)) {
            usersWithStatus.add(element);
          }
        }

        return Column(
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          child: AppCubit.get(context).user['image'] == 'image'
                              ? const ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/user-avatar.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image(
                                    image: NetworkImage(
                                      AppCubit.get(context).user['image'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppCubit.get(context).isDark
                                  ? AppColors.c3()
                                  : Colors.white,
                            ),
                            shape: BoxShape.circle,
                            color: AppColors.c1(),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'My status',
                            style: Theme.of(context).textTheme.headline2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tap to add status update',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : AppColors.c1(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey.withOpacity(.2),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: const Text(
                'Recent updates',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            ConditionalBuilder(
              condition: status.isNotEmpty,
              builder: (context) => Expanded(
                child: ListView.builder(
                  itemCount: status.length,
                  itemBuilder: (context, index) => statusItem(
                    context: context,
                    models: status[usersWithStatus[index].uId],
                    name: usersWithStatus[index].name,
                  ),
                ),
              ),
              fallback: (context) => Container(),
            ),
          ],
        );
      },
    );
  }
}
