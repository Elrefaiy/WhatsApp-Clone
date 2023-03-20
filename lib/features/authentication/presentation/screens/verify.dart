import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../cubit/authentication_cubit.dart';

class VerifyingScreen extends StatelessWidget {
  final String phoneNumber;
  const VerifyingScreen({
    required this.phoneNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var otpCodeController = TextEditingController();

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignInLoadingState ||
            state is SignInWithCredintialLoadingState) {
          AppConstants.showLoadingDialog(context);
        } else if (state is GetUserSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.profileInfo,
            (route) => false,
          );
        } else if (state is SignInErrorState) {
          Navigator.pop(context);
          AppConstants.showSnackBar(
            context: context,
            content: state.error,
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
                      AuthenticationCubit.get(context).submitOTP(
                        otpCode: otpCodeController.text,
                      );
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
