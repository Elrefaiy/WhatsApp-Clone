import 'package:flutter/material.dart';
import 'package:whatsapp_clone/config/routes/app_routes.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
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
          backgroundColor: AppColors.c2(),
          child: const Icon(Icons.message),
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.addTextStatus,
                );
              },
              mini: true,
              backgroundColor: Colors.blueGrey[100],
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[600],
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                HomeCubit.get(context).getStatusImage(context);
              },
              backgroundColor: AppColors.c2(),
              child: const Icon(Icons.camera_alt),
            ),
          ],
        );
      default:
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.c2(),
          child: const Icon(Icons.add_call),
        );
    }
  }
}
