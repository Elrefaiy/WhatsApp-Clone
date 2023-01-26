import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/models/status.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/modules/chat/chat_screen.dart';
import 'package:whatsapp_clone/modules/image_view/image_view.dart';
import 'package:whatsapp_clone/modules/status/mobile_status_screen.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

SnackBar snackBar({required String content}) => SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        content,
      ),
    );

showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
        ),
      ),
    ),
  );
}

Widget chatItem(
  context,
  UserModel model,
) =>
    InkWell(
      onTap: () {
        AppCubit.get(context).getChatMessages(model.uId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              model: model,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewScreen(
                      image: model.image,
                      name: model.name,
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 28,
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
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.name,
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        AppCubit.get(context).messages.isEmpty
                            ? ' '
                            : AppCubit.get(context)
                                .lastMessagesTime['time${model.uId}']
                                .toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (AppCubit.get(context).messages.isNotEmpty)
                        const Icon(
                          Icons.done_all,
                          color: Colors.blue,
                          size: 18,
                        ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          AppCubit.get(context).messages.isEmpty
                              ? 'tap to view messages'
                              : AppCubit.get(context)
                                  .lastMessages['message${model.uId}']
                                  .toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget webChatItem(
  context,
  UserModel model,
) =>
    InkWell(
      onTap: () {
        AppCubit.get(context).getChatMessages(model.uId);
      },
      child: Container(
        color: c6(),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.name,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        AppCubit.get(context).messages.isEmpty
                            ? ' '
                            : AppCubit.get(context)
                                .lastMessagesTime['time${model.uId}']
                                .toString(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (AppCubit.get(context).messages.isNotEmpty)
                        const Icon(
                          Icons.done_all,
                          color: Colors.blue,
                          size: 18,
                        ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          AppCubit.get(context).messages.isEmpty
                              ? 'tap to view messages'
                              : AppCubit.get(context)
                                  .lastMessages['message${model.uId}']
                                  .toString(),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget myMesseageItem({
  required context,
  required String content,
  required String time,
  isRead,
}) =>
    Align(
      alignment: Alignment.topRight,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: 20,
            height: 15,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color:
                  AppCubit.get(context).isDark ? c1() : const Color(0xffd9fdd3),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 15,
              left: 100,
            ),
            decoration: BoxDecoration(
              color:
                  AppCubit.get(context).isDark ? c1() : const Color(0xffd9fdd3),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                topLeft: Radius.circular(13),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: content.contains(
                          'https://firebasestorage.googleapis.com/v0/b/whatsapp-clone-61959.appspot.com')
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                  image: content,
                                  name: 'Media View',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  content,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          content,
                          maxLines: 100,
                          style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppCubit.get(context).isDark
                              ? Colors.grey[100]
                              : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.done_all_outlined,
                        color: Colors.blue[300],
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget friendMessageItem({
  required context,
  required String content,
  required String time,
  isRead,
}) =>
    Align(
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            width: 20,
            height: 15,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark ? c4() : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 100),
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark ? c4() : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: content.contains(
                          'https://firebasestorage.googleapis.com/v0/b/whatsapp-clone-61959.appspot.com')
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                  image: content,
                                  name: 'Media View',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  content,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          content,
                          maxLines: 100,
                          style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 3),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppCubit.get(context).isDark
                          ? Colors.grey[100]
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget interactiveItme(context, image) => InteractiveViewer(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: image == 'image'
            ? const Image(
                image: AssetImage(
                  'assets/images/user-avatar.jpg',
                ),
                fit: BoxFit.fitWidth,
              )
            : Image(
                image: NetworkImage(image),
                fit: BoxFit.fitWidth,
              ),
      ),
    );

Widget statusItem({
  required context,
  required List<StatusModel>? models,
  required name,
}) =>
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileStatusScreen(
              models: models,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            DashedCircle(
              dashes: models!.length,
              gapSize: 3,
              color: c2(),
              child: models.last.isImage
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Color(models.last.color),
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            models.last.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
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
                    name,
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // ignore: unrelated_type_equality_checks
                    '${models.last.date == DateFormat.yMMMd().format(DateTime.now()).toString() ? 'Today' : models.last.date}, ${models.last.time}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
