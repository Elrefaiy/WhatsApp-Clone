import 'package:flutter/material.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class VerifyingScreen extends StatelessWidget {
  const VerifyingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  'Verifying your number',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Waiting to automatically detect an SMS sent to +201069528303. Wrong number?',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 170,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: '_ _ _  _ _ _',
                      hintStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter 6-digit code',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: c2(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'NEXT',
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
      ),
    );
  }
}
