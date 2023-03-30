import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class AddTextStatusScreen extends StatelessWidget {
  const AddTextStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddStatusSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var textController = TextEditingController();
        return Scaffold(
          backgroundColor: Colors.teal,
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    iconSize: 24,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.faceGrinWide),
                    color: Colors.white,
                    iconSize: 22,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.font),
                    color: Colors.white,
                    iconSize: 22,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.palette),
                    color: Colors.white,
                    iconSize: 22,
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: textController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'Type a status',
                        hintStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(.5),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.c4(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: const Text(
                        'Status (Contacts)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.c2(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          HomeCubit.get(context).addTextStatus(
                            status: textController.text,
                            color: 0xff008069,
                          );
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
