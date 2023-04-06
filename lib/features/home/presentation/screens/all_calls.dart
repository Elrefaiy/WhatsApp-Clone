import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/endtoend_encrypted.dart';

class AllCalls extends StatelessWidget {
  const AllCalls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // !TODO: To Be Implemented Soon ...
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.c2(),
                  child: const Icon(
                    Icons.link,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create call link',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Share a link for your WhatsApp call',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.blueGrey.withOpacity(.5),
        ),
        const EndToEndWidget(feature: 'calls'),
        const SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 5,
            children: const [
              Text(
                'To start calling contacts who have ',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              Text(
                'WhatsApp, tap ',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.add_call,
                color: Colors.blueGrey,
                size: 18,
              ),
              Text(
                ' at the bottom of your ',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              Text(
                'screen.',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
