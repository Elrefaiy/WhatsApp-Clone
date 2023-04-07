import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/image_view.dart';
import '../cubit/home_cubit.dart';

class MediaViewScreen extends StatelessWidget {
  const MediaViewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('Chat Media'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (HomeCubit.get(context).media.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    HomeCubit.get(context).media.last.date,
                  ),
                ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: List.generate(
                    HomeCubit.get(context).media.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.imageView,
                          arguments: ImageViewArgs(
                            name: 'Media View',
                            image: HomeCubit.get(context).media[index].message,
                          ),
                        );
                      },
                      child: Image(
                        image: NetworkImage(
                          HomeCubit.get(context).media[index].message,
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
