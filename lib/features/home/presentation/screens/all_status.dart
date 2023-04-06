import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/home_cubit.dart';
import '../widgets/endtoend_encrypted.dart';
import '../widgets/status_item.dart';

class AllStatus extends StatelessWidget {
  const AllStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget myStatus() {
          if (HomeCubit.get(context).myStatus.isEmpty) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                AppConstants.userImage(
                  radius: 28,
                  image: AuthenticationCubit.get(context).currentUser != null
                      ? AuthenticationCubit.get(context).currentUser!.image
                      : 'image',
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: SettingsCubit.get(context).isDark
                          ? AppColors.c3()
                          : Colors.white,
                    ),
                    shape: BoxShape.circle,
                    color: AppColors.c1(),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            );
          } else {
            return DashedCircle(
              dashes: HomeCubit.get(context).myStatus.length,
              gapSize: 3,
              color: AppColors.c2(),
              child: HomeCubit.get(context).myStatus.last.isImage
                  ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          HomeCubit.get(context).myStatus.last.status,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Color(
                          HomeCubit.get(context).myStatus.last.color,
                        ),
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            HomeCubit.get(context).myStatus.last.status,
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
            );
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                if (HomeCubit.get(context).myStatus != []) {
                  Navigator.pushNamed(
                    context,
                    Routes.status,
                    arguments: HomeCubit.get(context).myStatus,
                  );
                } else {
                  HomeCubit.get(context).getStatusImage(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    myStatus(),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'My status',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tap to add status update',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: SettingsCubit.get(context).isDark
                            ? Colors.white
                            : AppColors.c1(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey.withOpacity(.1),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: const Text(
                'Recent updates',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            if (HomeCubit.get(context).contactsStatus != {})
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: HomeCubit.get(context).contactsStatus.length,
                itemBuilder: (context, index) {
                  return StatusWidget(
                    status: HomeCubit.get(context).contactsStatus[
                        HomeCubit.get(context).statusId[index]]!,
                    name: HomeCubit.get(context)
                        .searchUser(HomeCubit.get(context).statusId[index])
                        .name,
                  );
                },
              ),
            Divider(
              color: Colors.blueGrey.withOpacity(.5),
            ),
            const EndToEndWidget(feature: 'status'),
          ],
        );
      },
    );
  }
}
