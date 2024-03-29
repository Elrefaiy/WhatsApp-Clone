import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';

class FriendMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const FriendMessageWidget({
    required this.content,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            width: 20,
            height: 15,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: SettingsCubit.get(context).isDark
                  ? AppColors.c4()
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Container(
            width: content.contains(
              'https://firebasestorage.googleapis.com/v0/b/whatsapp-clone-61959.appspot.com',
            )
                ? 300
                : null,
            margin: const EdgeInsets.only(left: 15, right: 100),
            decoration: BoxDecoration(
              color: SettingsCubit.get(context).isDark
                  ? AppColors.c4()
                  : Colors.white,
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
                    'https://firebasestorage.googleapis.com/v0/b/whatsapp-clone-61959.appspot.com',
                  )
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.imageView,
                              arguments: ImageViewArgs(
                                name: 'Media View',
                                image: content,
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
                            color: SettingsCubit.get(context).isDark
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
                      color: SettingsCubit.get(context).isDark
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
  }
}
