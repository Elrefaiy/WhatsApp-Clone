import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/image_view/image_view.dart';

// ignore: must_be_immutable
class MediaViewScreen extends StatelessWidget {
  String name;
  MediaViewScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(name),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppCubit.get(context).media.last.date,
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: List.generate(
                    AppCubit.get(context).media.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                              image: AppCubit.get(context).media[index].message,
                              name: name,
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: NetworkImage(
                          AppCubit.get(context).media[index].message,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
