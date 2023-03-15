import 'package:flutter/material.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/features/home/presentation/cubit/home_cubit.dart';

class FAB extends StatelessWidget {
  final int index;
  const FAB({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {
            HomeCubit.get(context).getAllUsers();
            Navigator.pushNamed(
              context,
              Routes.contacts,
            );
          },
          child: const Icon(Icons.message),
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              mini: true,
              child: const Icon(Icons.edit),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: const Icon(Icons.camera_alt),
            ),
          ],
        );
      default:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.call),
        );
    }
  }
}
