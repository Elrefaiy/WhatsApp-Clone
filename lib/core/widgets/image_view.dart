import 'package:flutter/material.dart';

import '../utils/app_strings.dart';

class ImageViewScreen extends StatelessWidget {
  final ImageViewArgs args;
  const ImageViewScreen({
    required this.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(args.name),
        titleSpacing: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: InteractiveViewer(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: args.image == 'image'
                ? const Image(
                    image: AssetImage(
                      AppStrings.noUserImage,
                    ),
                    fit: BoxFit.fitWidth,
                  )
                : Image(
                    image: NetworkImage(args.image),
                    fit: BoxFit.fitWidth,
                  ),
          ),
        ),
      ),
    );
  }
}

class ImageViewArgs {
  final String name;
  final String image;

  ImageViewArgs({
    required this.name,
    required this.image,
  });
}
