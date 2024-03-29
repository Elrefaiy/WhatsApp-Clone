import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
import '../cubit/home_cubit.dart';
import '../widgets/freind_message_item.dart';
import '../widgets/my_message_item.dart';

class ChatScreen extends StatelessWidget {
  final User model;
  const ChatScreen({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var messageController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                AppConstants.userImage(
                  radius: 20,
                  image: model.image,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    HomeCubit.get(context).getChatMedia(
                      recieverId: model.uId,
                    );
                    Navigator.pushNamed(
                      context,
                      Routes.chatMedia,
                    );
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
                  SettingsCubit.get(context).isDark
                      ? AppStrings.chatDark
                      : AppStrings.chatLight,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: StreamBuilder<List<Message>>(
                    stream: HomeCubit.get(context).curruntChatMessages,
                    builder: (context, snapshot) {
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
                    },
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
                          color: SettingsCubit.get(context).isDark
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
                                style: Theme.of(context).textTheme.bodyText1,
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
                                      receiverId: model.uId,
                                    );
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                HomeCubit.get(context).getGalleryImage(
                                  context: context,
                                  recieverId: model.uId,
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
                            HomeCubit.get(context).sendTextMessage(
                              message: messageController.text,
                              time: DateTime.now().toString().substring(11, 16),
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
