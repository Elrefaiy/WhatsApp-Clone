import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/status.dart';

class MobileStatusScreen extends StatelessWidget {
  final List<StatusModel> models;
  const MobileStatusScreen({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    var storyController = StoryController();
    List<StoryItem> storyItems = List.generate(
      models.length,
      (index) => models[index].isImage
          ? StoryItem.inlineImage(
              url: models[index].status,
              controller: storyController,
              caption: Text(
                textAlign: TextAlign.center,
                models[index].caption,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          : StoryItem.text(
              textStyle: const TextStyle(
                fontSize: 30,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
              ),
              title: models[index].status,
              backgroundColor: Color(models[index].color),
            ),
    );

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return StoryView(
          storyItems: storyItems,
          controller: storyController,
          onComplete: () {
            Navigator.pop(context);
          },
          inline: true,
          onStoryShow: (storyItem) {},
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
