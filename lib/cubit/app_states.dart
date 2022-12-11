abstract class AppStates {}

class AppInitialState extends AppStates {}

class SubmitPhoneNumberLoadingState extends AppStates {}

class SubmitPhoneNumberSuccessState extends AppStates {}

class SubmitPhoneNumberErrorState extends AppStates {
  String error;
  SubmitPhoneNumberErrorState(this.error);
}

class SignInLoadingState extends AppStates {}

class SignInSuccessState extends AppStates {}

class SignInErrorState extends AppStates {
  String error;
  SignInErrorState(this.error);
}
