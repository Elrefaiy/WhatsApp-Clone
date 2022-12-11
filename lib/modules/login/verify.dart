import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/modules/login/profile_info.dart';
import 'package:whatsapp_clone/shared/components/components.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';

class VerifyingScreen extends StatelessWidget {
  final String phoneNumber;
  const VerifyingScreen({
    required this.phoneNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var otpCodeController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          showLoadingDialog(context);
        } else if (state is SignInSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileInfoScreen(),
            ),
          );
        } else if (state is SignInErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              content: state.error.toString(),
            ),
          );
        }
      },
      builder: (context, state) {
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
                      'Waiting to automatically detect an SMS sent to $phoneNumber. Wrong number?',
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
                        controller: otpCodeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required !';
                          } else if (value.length != 6) {
                            return 'Invalid OTP Code!';
                          }
                          return null;
                        },
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
                      onTap: () {
                        AppCubit.get(context).submitOTP(otpCodeController.text);
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
        );
      },
    );
  }
}
