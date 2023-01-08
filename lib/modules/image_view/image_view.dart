import 'package:flutter/material.dart';
import 'package:whatsapp_clone/shared/components/components.dart';

// ignore: must_be_immutable
class ImageViewScreen extends StatelessWidget {
  late String image;
  late String name;
  ImageViewScreen({required this.image, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(image);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(name),
        titleSpacing: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(child: interactiveItme(context, image)),
    );
  }
}
