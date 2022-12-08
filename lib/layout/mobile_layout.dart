import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // bottom: TabBar(
          //   controller: TabController(
          //     length: 1,
          //     vsync: ,
          //   ),
          //   tabs: const [
          //     Text('aaa'),
          //     Text('aaa'),
          //     Text('aaa'),
          //   ],
          // ),
          ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.message,
        ),
      ),
    );
  }
}
