import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/modules/chat/media_view.dart';
import 'package:whatsapp_clone/modules/user_info/user_info.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  final UserModel model;
  const ChatScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetChatMediaSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaViewScreen(
                name: model.name,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var messageController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  child: model.image == 'image'
                      ? ClipOval(child: AppConstants.noUserImage())
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoScreen(
                            userModel: model,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).getChatMedia(model.uId);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
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
                      color: AppCubit.get(context).isDark
                          ? AppColors.c4()
                          : Colors.white,
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
                              ? AppColors.c4()
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
                              onPressed: () {
                                AppCubit.get(context).getMessageImage(
                                  context,
                                  model.uId,
                                );
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 28,
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
                        color: AppColors.c2(),
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
