import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../domain/entities/status.dart';

class StatusScreen extends StatelessWidget {
  final List<Status> status;
  const StatusScreen({
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var storyController = StoryController();
    List<StoryItem> storyItems = List.generate(
      status.length,
      (index) => status[index].isImage
          ? StoryItem.inlineImage(
              url: status[index].status,
              controller: storyController,
              caption: Text(
                textAlign: TextAlign.center,
                status[index].caption,
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
              title: status[index].status,
              backgroundColor: Color(status[index].color),
            ),
    );

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
  }
}
