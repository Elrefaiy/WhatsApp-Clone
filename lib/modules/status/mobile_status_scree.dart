import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';

class MobileStatusScreen extends StatelessWidget {
  const MobileStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.text(
        textStyle: Theme.of(context).textTheme.headline1,
        title: 'Story 1',
        backgroundColor: Colors.black,
      ),
      StoryItem.text(
        title: 'Story 2',
        backgroundColor: Colors.red,
      ),
      StoryItem.text(
        title: 'Story 3',
        backgroundColor: Colors.grey,
      ),
    ];

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return StoryView(
          storyItems: storyItems,
          controller: StoryController(),
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
