import 'package:flutter/material.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';

class ContactItem extends StatelessWidget {
  final User user;
  const ContactItem({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeCubit.get(context).getChatMessages(
          image: user.image,
          name: user.name,
          uId: user.uId,
        );
        Navigator.pushNamed(
          context,
          Routes.chat,
          arguments: user,
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
              onTap: () {},
              child: AppConstants.userImage(
                radius: 22,
                image: user.image,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.uId == AuthenticationCubit.get(context).currentUser.uId
                        ? '${user.phone} (You)'
                        : user.name,
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.about,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2,
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
