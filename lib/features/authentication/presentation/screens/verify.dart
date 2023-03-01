import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/utils/app_colors.dart';
import 'package:whatsapp_clone/core/utils/app_constants.dart';
import 'package:whatsapp_clone/cubit/app_cubit.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/features/authentication/presentation/screens/profile_info.dart';

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
          AppConstants.showLoadingDialog(context);
        } else if (state is GetUserSuccessState) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileInfoScreen(),
            ),
            (route) => false,
          );
        } else if (state is SignInErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            AppConstants.showSnackBar(
              context: context,
              content: state.error.toString(),
            ),
          );
        }
      },
      builder: (context, state) {
        Widget bodyBuilder() {
          return Center(
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Waiting to automatically detect an SMS sent to',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        TextSpan(
                          text: ' $phoneNumber.',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(
                          text: ' Wrong number?',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.blue,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: 170,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                          ),
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
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: '_ _ _  _ _ _',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 16,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Didn\'t receive code?',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
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
                        color: AppColors.c2(),
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
          );
        }

        return MediaQuery(
          data: AppConstants.mediaQueryData(context),
          child: SafeArea(
            child: Scaffold(
              body: bodyBuilder(),
            ),
          ),
        );
      },
    );
  }
}
