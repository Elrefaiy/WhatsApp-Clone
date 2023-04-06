import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/image_view.dart';
import '../../domain/entities/contact.dart';
import '../cubit/home_cubit.dart';

class ChatWidget extends StatelessWidget {
  final Contact contact;
  const ChatWidget({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeCubit.get(context).getChatMessages(
          image: contact.image,
          name: contact.name,
          uId: contact.uId,
        );
        Navigator.pushNamed(
          context,
          Routes.chat,
          arguments: HomeCubit.get(context).searchUser(
            contact.uId,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.imageView,
                  arguments: ImageViewArgs(
                    name: contact.name,
                    image: contact.image,
                  ),
                );
              },
              child: AppConstants.userImage(
                radius: 28,
                image: contact.image,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        contact.dateTime.substring(11, 16),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        contact.lastMessage == 'Picture'
                            ? Icons.image
                            : Icons.done_all,
                        color: contact.lastMessage == 'Picture'
                            ? Colors.blueGrey
                            : Colors.blue,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          contact.lastMessage,
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
  }
}
