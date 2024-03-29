import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/authentication_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var countryController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SubmitPhoneNumberLoadingState) {
          AppConstants.showLoadingDialog(context);
        } else if (state is SubmitPhoneNumberSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            Routes.verify,
            arguments: '+${countryController.text}${phoneController.text}',
          );
        } else if (state is SubmitPhoneNumberErrorState) {
          Navigator.pop(context);
          AppConstants.showSnackBar(
            context: context,
            content: AppStrings.loginWarning,
          );
        }
      },
      builder: (context, state) {
        Widget bodyBuilder() {
          return Form(
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
                    const SizedBox(height: 30),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'WhatsApp will need to verify your phone number.',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          TextSpan(
                            text: ' What\'s my number?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 270,
                      child: Column(
                        children: [
                          DropdownButtonFormField(
                            elevation: 0,
                            dropdownColor: SettingsCubit.get(context).isDark
                                ? AppColors.c4()
                                : Colors.grey[100],
                            style: Theme.of(context).textTheme.bodyText1,
                            borderRadius: BorderRadius.circular(5),
                            autofocus: true,
                            onChanged: (value) {
                              countryController.text = value.toString();
                            },
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText1,
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
                                  decoration: InputDecoration(
                                    prefix: Text(
                                      '+',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 5,
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText1,
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required !';
                                    } else if (value.length != 10) {
                                      return 'Invalid Phone Number!';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'phone number',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          AuthenticationCubit.get(context).submitPhoneNumber(
                            phone: phoneController.text,
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
                          color: AppColors.c2(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
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
