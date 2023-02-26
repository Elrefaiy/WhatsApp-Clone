import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/user.dart';

class UserInfoScreen extends StatelessWidget {
  final UserModel userModel;
  const UserInfoScreen({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                CircleAvatar(
                  radius: 70,
                  child: userModel.image == 'image'
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
                              userModel.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                Text(
                  userModel.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  userModel.phone,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userModel.about,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
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
