import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'WhatsApp',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              SizedBox(
                height: 30,
                child: Text('Status'),
              ),
              SizedBox(
                height: 30,
                child: Text('Status'),
              ),
              SizedBox(
                height: 30,
                child: Text('Status'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text(
                '111111',
                textScaleFactor: 2,
              ),
            ),
            Center(
              child: Text(
                '222222',
                textScaleFactor: 2,
              ),
            ),
            Center(
              child: Text(
                '33333',
                textScaleFactor: 2,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.message,
          ),
        ),
      ),
    );
  }
}
