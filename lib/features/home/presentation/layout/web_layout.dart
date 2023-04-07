import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/message.dart';
import '../cubit/home_cubit.dart';
import '../widgets/freind_message_item.dart';
import '../widgets/my_message_item.dart';
import '../widgets/web_chat_item.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key});

  Container cotactsBuilder(BuildContext context) {
    return Container(
      width: context.width >= 560 ? 410 : 300,
      decoration: BoxDecoration(
        color:
            SettingsCubit.get(context).isDark ? AppColors.c3() : Colors.white,
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
            color: SettingsCubit.get(context).isDark
                ? AppColors.c4()
                : AppColors.c6(),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                AppConstants.userImage(
                  radius: 35,
                  image: AuthenticationCubit.get(context).currentUser != null
                      ? AuthenticationCubit.get(context).currentUser!.image
                      : 'image',
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.users,
                    size: 16,
                    color: SettingsCubit.get(context).isDark
                        ? Colors.blueGrey[200]
                        : Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.data_usage_rounded,
                    size: 20,
                    color: SettingsCubit.get(context).isDark
                        ? Colors.blueGrey[200]
                        : Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat,
                    size: 20,
                    color: SettingsCubit.get(context).isDark
                        ? Colors.blueGrey[200]
                        : Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SettingsCubit.get(context).changeMode();
                  },
                  icon: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: SettingsCubit.get(context).isDark
                        ? Colors.blueGrey[200]
                        : Colors.blueGrey,
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
                      color: SettingsCubit.get(context).isDark
                          ? AppColors.c7()
                          : AppColors.c6(),
                      borderRadius: BorderRadius.circular(5),
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
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search or start new chat',
                              hintStyle: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FaIcon(
                  FontAwesomeIcons.bars,
                  color: SettingsCubit.get(context).isDark
                      ? Colors.blueGrey[200]
                      : Colors.blueGrey,
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
              itemBuilder: (context, index) => WebChatItem(
                contact: HomeCubit.get(context).allContacts[index],
              ),
              itemCount: HomeCubit.get(context).allContacts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget initalChat(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: SettingsCubit.get(context).isDark
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
                SettingsCubit.get(context).isDark
                    ? AppStrings.webDark
                    : AppStrings.webLight,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'WhatsApp Web',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.webInitial,
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
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chatWidget(context) {
    final messageController = TextEditingController();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              SettingsCubit.get(context).isDark
                  ? AppStrings.chatDark
                  : AppStrings.chatLight,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 54,
              color: SettingsCubit.get(context).isDark
                  ? AppColors.c4()
                  : AppColors.c6(),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  AppConstants.userImage(
                    radius: 24,
                    image: HomeCubit.get(context).currentContact!.image,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      HomeCubit.get(context).currentContact!.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 20,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.blueGrey[200]
                          : Colors.blueGrey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.blueGrey[200]
                          : Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (HomeCubit.get(context).curruntChatMessages != null)
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: HomeCubit.get(context).curruntChatMessages,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListView.separated(
                        controller: HomeCubit.get(context).chatController,
                        itemBuilder: (context, index) {
                          if (snapshot.data![index].recieverId !=
                              AuthenticationCubit.get(context)
                                  .currentUser!
                                  .uId) {
                            return MyMessageWidget(
                              content: snapshot.data![index].message,
                              time: snapshot.data![index].time,
                            );
                          } else {
                            return FriendMessageWidget(
                              content: snapshot.data![index].message,
                              time: snapshot.data![index].time,
                            );
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Spacer();
                    }
                  },
                ),
              ),
            Container(
              color: SettingsCubit.get(context).isDark
                  ? AppColors.c7()
                  : AppColors.c6(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.faceGrinWide,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.blueGrey[200]
                          : Colors.blueGrey,
                      size: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).getGalleryImage(
                        context: context,
                        recieverId: HomeCubit.get(context).currentContact!.uId,
                      );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.paperclip,
                      size: 18,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.blueGrey[200]
                          : Colors.blueGrey,
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
                        color: SettingsCubit.get(context).isDark
                            ? AppColors.c8()
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: messageController,
                        style: Theme.of(context).textTheme.bodyText2,
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
                          if (messageController.text.isNotEmpty) {
                            HomeCubit.get(context).sendTextMessage(
                              message: messageController.text,
                              time: DateTime.now().toString().substring(
                                    11,
                                    16,
                                  ),
                              date: DateFormat.yMMMd()
                                  .format(DateTime.now())
                                  .toString(),
                              dateTime: DateTime.now().toString(),
                              receiverId:
                                  HomeCubit.get(context).currentContact!.uId,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        HomeCubit.get(context).sendTextMessage(
                          message: messageController.text,
                          time: DateTime.now().toString().substring(11, 16),
                          date: DateFormat.yMMMd()
                              .format(DateTime.now())
                              .toString(),
                          dateTime: DateTime.now().toString(),
                          receiverId:
                              HomeCubit.get(context).currentContact!.uId,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: SettingsCubit.get(context).isDark
                          ? Colors.blueGrey[200]
                          : Colors.blueGrey,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              cotactsBuilder(context),
              HomeCubit.get(context).currentContact == null
                  ? initalChat(context)
                  : chatWidget(context),
            ],
          ),
        );
      },
    );
  }
}
