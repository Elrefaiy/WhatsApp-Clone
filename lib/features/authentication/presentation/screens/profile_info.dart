import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetAllUsersLoadingState) {
          AppConstants.showLoadingDialog(context);
        } else if (state is GetAllUsersSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var nameController = TextEditingController();
        String image = AppCubit.get(context).user['image'] ?? 'image';
        nameController.text = AppCubit.get(context).user['name'];

        Widget bodyBuilder() {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    'Profile info',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Please provide your name and an optional profile photo',
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.showBottomSheet(
                        backgroundColor: AppCubit.get(context).isDark
                            ? AppColors.c3()
                            : Colors.white,
                        (context) => Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppCubit.get(context).isDark
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
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context)
                                          .updateProfileImage(image: 'image');
                                      AppCubit.get(context).getUser();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            AppCubit.get(context)
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
                                  const SizedBox(width: 30),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            AppCubit.get(context)
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
                    child: CircleAvatar(
                      radius: 65,
                      child: image == 'image'
                          ? ClipOval(
                              child: AppConstants.noUserImage(),
                            )
                          : ClipOval(
                              child: Image(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 250,
                        child: TextFormField(
                          controller: nameController,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLength: 25,
                          onFieldSubmitted: (value) {
                            AppCubit.get(context).updateName(
                              name: value,
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.faceGrinWide,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      AppCubit.get(context).getUsers();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.c2(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return MediaQuery(
          data: AppConstants.mediaQueryData(context),
          child: SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              body: bodyBuilder(),
            ),
          ),
        );
      },
    );
  }
}