import 'package:flutter/material.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 50,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to WhatsApp',
                style: Theme.of(context).textTheme.headline1,
              ),
              const Spacer(),
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/welcome-light.jpg',
                ),
                radius: 140,
                backgroundColor: Colors.white,
              ),
              const Spacer(),
              Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 90,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: c2(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'AGREE AND CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
