import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/core/widgets/image_view.dart';
import 'package:whatsapp_clone/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp_clone/features/settings/presentation/cubit/settings_cubit.dart';

class MobileProfile extends StatelessWidget {
  const MobileProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is UpdateUserLoadingState) {
          AppConstants.showLoadingDialog(context);
        } else if (state is UpdateUserSuccessState) {
          Navigator.pop(context);
        } else if (state is UpdateUserErrorState) {
          Navigator.pop(context);
          AppConstants.showSnackBar(
            context: context,
            content: AppStrings.somethingWrong,
          );
        }
      },
      builder: (context, state) {
        var scaffoldKey = GlobalKey<ScaffoldState>();
        var user = AuthenticationCubit.get(context).currentUser;
        var nameController = TextEditingController();
        var aboutController = TextEditingController();

        nameController.text = user!.name;
        aboutController.text = user.about;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.imageView,
                        arguments: ImageViewArgs(
                          image: user.image,
                          name: 'Profile Photo',
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'Profile',
                      child: AppConstants.userImage(
                        radius: 80,
                        image: user.image,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.c2(),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        scaffoldKey.currentState!.showBottomSheet(
                          backgroundColor: SettingsCubit.get(context).isDark
                              ? AppColors.c3()
                              : Colors.white,
                          (context) => Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: SettingsCubit.get(context).isDark
                                  ? AppColors.c4()
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(.1),
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Profile photo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: Colors.grey[600]),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                                width: 1,
                                              )),
                                          child: IconButton(
                                            onPressed: () {
                                              AuthenticationCubit.get(context)
                                                  .getCameraImage(context);
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.teal,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Camera',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                                width: 1,
                                              )),
                                          child: IconButton(
                                            onPressed: () {
                                              AuthenticationCubit.get(context)
                                                  .getGalleryImage(context);
                                            },
                                            icon: const Icon(
                                              Icons.image_rounded,
                                              color: Colors.teal,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Gallery',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.showBottomSheet(
                    backgroundColor: SettingsCubit.get(context).isDark
                        ? AppColors.c3()
                        : Colors.white,
                    (context) => Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: SettingsCubit.get(context).isDark
                            ? AppColors.c4()
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 10,
                            blurRadius: 20,
                            color: Colors.black.withOpacity(.1),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your name',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: nameController,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    autofocus: true,
                                    maxLength: 25,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(
                                Icons.tag_faces_sharp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  AuthenticationCubit.get(context)
                                      .updateUsername(
                                    username: nameController.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 24,
                        color: AppColors.c5(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'This is not your username or pin. This name will be visible to your WhatsApp contacts.',
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        size: 24,
                        color: AppColors.c2(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Divider(
                  color: Colors.grey.withOpacity(.7),
                  height: 4,
                ),
              ),
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.showBottomSheet(
                    backgroundColor: SettingsCubit.get(context).isDark
                        ? AppColors.c3()
                        : Colors.white,
                    (context) => Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: SettingsCubit.get(context).isDark
                            ? AppColors.c4()
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 10,
                            blurRadius: 20,
                            color: Colors.black.withOpacity(.1),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add About',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: aboutController,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    autofocus: true,
                                    maxLength: 140,
                                    decoration: InputDecoration(
                                      hintText: 'About',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(
                                Icons.tag_faces_sharp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  AuthenticationCubit.get(context).updateAbout(
                                    about: aboutController.text,
                                  );
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 24,
                        color: AppColors.c5(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              user.about,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        size: 24,
                        color: AppColors.c2(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Divider(
                  color: Colors.grey.withOpacity(.7),
                  height: 4,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 24,
                        color: AppColors.c5(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              user.phone,
                              style: Theme.of(context).textTheme.bodyText1,
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
