import 'package:flutter/material.dart';
import 'package:whatsapp_clone/modules/chat/chat_screen.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

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

Widget chatItem(context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
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
            const CircleAvatar(
              radius: 28,
              child: ClipOval(
                child: Image(
                  image: AssetImage(
                    'assets/images/user-avatar.jpg',
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
                          'General Chat',
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '02:41',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.done_all,
                        color: Colors.blue,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Hello Ahmed',
                        style: Theme.of(context).textTheme.bodyText2,
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
  String message = 'my friend ! 😄😄',
  time,
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
              color: c1(),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15, left: 80),
            constraints: const BoxConstraints(
              minWidth: 100,
              minHeight: 30,
              maxHeight: double.infinity,
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              color: c1(),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                topLeft: Radius.circular(13),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    message,
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 3),
                  child: Text(
                    '12:00',
                    style: TextStyle(color: Colors.blueGrey[100]),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 3, 3),
                  child: Icon(
                    Icons.done_all_outlined,
                    color: Colors.blue[300],
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget frienMessageItem() => Align(
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            width: 20,
            height: 15,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: c4(),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 80),
            constraints: const BoxConstraints(
              minWidth: 100,
              minHeight: 30,
              maxHeight: double.infinity,
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              color: c4(),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 2, 0, 3),
                  child: Icon(
                    Icons.done_all_outlined,
                    color: Colors.blue[300],
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 2, 0, 3),
                  child: Text(
                    '12:00',
                    style: TextStyle(color: Colors.blueGrey[100]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'my friend ! 😄😄',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
