import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                const CircleAvatar(
                  child: ClipOval(
                    child: Image(
                      image: AssetImage(
                        'assets/images/user-avatar.jpg',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'User Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                )
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppCubit.get(context).isDark
                      ? 'assets/images/chat-dark.jpg'
                      : 'assets/images/chat-light.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark ? c4() : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'July 24, 2022',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                myMesseageItem(context: context),
                const SizedBox(
                  height: 8,
                ),
                frienMessageItem(context),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppCubit.get(context).isDark
                              ? c4()
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.solidFaceGrin,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.paperclip,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 8,
                      ),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: c2(),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
