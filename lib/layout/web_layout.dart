import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:intl/intl.dart';

class WebLayout extends StatelessWidget {
  final UserModel model;
  const WebLayout({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var messageController = TextEditingController();
        List users = AppCubit.get(context).users;

        return Scaffold(
          body: Row(
            children: [
              Container(
                width: 410,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: Colors.blueGrey.withOpacity(.2),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 54,
                      color: AppColors.c6(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 35,
                            child: ClipOval(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/user-avatar.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.users,
                              size: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.data_usage_rounded,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.chat,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      width: 410,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 34,
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.c6(),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.blueGrey,
                                        size: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search or start new chat',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.bars,
                            color: Colors.blueGrey,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey.withOpacity(.2),
                      thickness: 1,
                      height: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            webChatItem(context, users[index]),
                        itemCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////
              AppCubit.get(context).messages.isEmpty
                  ? Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppCubit.get(context).isDark
                              ? const Color(0xff212E36)
                              : AppColors.c6(),
                          border: Border(
                            bottom: BorderSide(
                              width: 8,
                              color: AppColors.c2(),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                AppCubit.get(context).isDark
                                    ? 'assets/images/web-dark.jpg'
                                    : 'assets/images/web-light.jpg',
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'WhatsApp Web',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'send and receive messages without keeping your phone online.\nUse WhatsApp on up to 4 linked devices and 1 phone at the same time.',
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 80),
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
                                Text(
                                  'End-to-end encrypted',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 11,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
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
                            Container(
                              height: 54,
                              color: AppColors.c6(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Row(
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
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.name,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_vert,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var message =
                                      AppCubit.get(context).messages[index];
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
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 5,
                                ),
                                itemCount:
                                    AppCubit.get(context).messages.length,
                              ),
                            ),
                            Container(
                              color: AppColors.c6(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.faceGrinWide,
                                      color: Colors.blueGrey,
                                      size: 22,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.paperclip,
                                      size: 18,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 38,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 10,
                                      ),
                                      padding: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: messageController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        keyboardType: TextInputType.multiline,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Type a message',
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        onFieldSubmitted: (text) {
                                          if (messageController
                                              .text.isNotEmpty) {
                                            AppCubit.get(context).sendMessage(
                                              content: messageController.text,
                                              time: DateTime.now()
                                                  .toString()
                                                  .substring(
                                                    11,
                                                    16,
                                                  ),
                                              date: DateFormat.yMMMd()
                                                  .format(DateTime.now())
                                                  .toString(),
                                              dateTime:
                                                  DateTime.now().toString(),
                                              receiverId: model.uId,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (messageController.text.isNotEmpty) {
                                        AppCubit.get(context).sendMessage(
                                          content: messageController.text,
                                          time: DateTime.now()
                                              .toString()
                                              .substring(
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
                                      color: Colors.blueGrey,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
