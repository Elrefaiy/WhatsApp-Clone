import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/login/verify.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var countryController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SubmitPhoneNumberLoadingState) {
          showLoadingDialog(context);
        } else if (state is SubmitPhoneNumberSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyingScreen(
                phoneNumber:
                    '+${countryController.text}${phoneController.text}',
              ),
            ),
          );
        } else if (state is SubmitPhoneNumberErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              content: 'Something went wrong, please try again',
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
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
                              onChanged: (value) {
                                countryController.text = value.toString();
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text('Egypt'),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text('United States'),
                                ),
                                DropdownMenuItem(
                                  value: 4,
                                  child: Text('Amirica'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: countryController,
                                    readOnly: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required !';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      prefix: Text('+'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: phoneController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required !';
                                      } else if (value.length != 11) {
                                        return 'Invalid Phone Number!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      hintText: 'phone number',
                                    ),
                                  ),
                                ),
                              ],
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
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).submitPhoneNumber(
                              phoneNumber: phoneController.text,
                              country: countryController.text,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
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
          ),
        );
      },
    );
  }
}
