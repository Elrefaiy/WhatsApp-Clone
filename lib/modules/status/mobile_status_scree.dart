import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class MobileStatusScreen extends StatelessWidget {
  const MobileStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var storyController = StoryController();
    List<StoryItem> storyItems = [
      StoryItem.text(
        textStyle: Theme.of(context).textTheme.headline1,
        title: 'Story 1',
        backgroundColor: c1(),
      ),
      StoryItem.inlineImage(
        url:
            'https://f-tep.com/wp-content/uploads/2020/09/ftep-hero1-1536x1024.jpg',
        controller: storyController,
        caption: Text(
          textAlign: TextAlign.center,
          "Hektas, sektas and skatad",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    ];

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
