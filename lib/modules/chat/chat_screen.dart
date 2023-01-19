import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  UserModel model;
  ChatScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var messageController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  child: model.image == 'image'
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
                              model.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    model.name,
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
                  height: 5,
                ),
                if (AppCubit.get(context).messages.isNotEmpty)
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
                      AppCubit.get(context).messages.first.date,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    controller: AppCubit.get(context).chatController,
                    itemBuilder: (context, index) {
                      var message = AppCubit.get(context).messages[index];
                      if (message.recieverId !=
                          AppCubit.get(context).user['uId']) {
                        return myMesseageItem(
                          context: context,
                          content: message.message,
                          time: message.time,
                        );
                      } else {
                        return friendMessageItem(
                          context: context,
                          content: message.message,
                          time: message.time,
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: AppCubit.get(context).messages.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                FontAwesomeIcons.faceGrinWide,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                onFieldSubmitted: (text) {
                                  if (messageController.text.isNotEmpty) {
                                    AppCubit.get(context).sendMessage(
                                      content: messageController.text,
                                      time: DateTime.now().toString().substring(
                                            11,
                                            16,
                                          ),
                                      date: DateFormat.yMMMd()
                                          .format(DateTime.now())
                                          .toString(),
                                      dateTime: DateTime.now().toString(),
                                      receiverId: model.uId,
                                    );
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.camera,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: c2(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            AppCubit.get(context).sendMessage(
                              content: messageController.text,
                              time: DateTime.now().toString().substring(
                                    11,
                                    16,
                                  ),
                              date: DateFormat.yMMMd()
                                  .format(DateTime.now())
                                  .toString(),
                              dateTime: DateTime.now().toString(),
                              receiverId: model.uId,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
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
