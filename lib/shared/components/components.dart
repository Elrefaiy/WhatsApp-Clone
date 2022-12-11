import 'package:flutter/material.dart';

SnackBar snackBar({required String content}) => SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        content,
      ),
    );

showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
        ),
      ),
    ),
  );
}

Widget chatItem(context) => Row(
      children: [
        const CircleAvatar(
          radius: 28,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'General Chat',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  const Text('02:41'),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.done_all,
                    color: Colors.blue,
                    size: 18,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Hello Ahmed',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
