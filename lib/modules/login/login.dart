import 'package:flutter/material.dart';
import 'package:whatsapp_clone/modules/login/verify.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Enter your phone number',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'WhatsApp will need to verify your phone number. What\'s my number?',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 270,
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(5),
                        autofocus: true,
                        onChanged: (value) {},
                        items: const [
                          DropdownMenuItem(
                            value: 20,
                            child: Text('Egypt'),
                          ),
                          DropdownMenuItem(
                            value: 30,
                            child: Text('United States'),
                          ),
                          DropdownMenuItem(
                            value: 40,
                            child: Text('Amirica'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  prefix: Text('+  '),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'phone number',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Carrier charges my apply',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyingScreen(),
                      ),
                    );
                  },
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
