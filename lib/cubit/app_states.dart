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

class LogoutLoadingState extends AppStates {}

class LogoutSuccessState extends AppStates {}

class ChangeCurrentIndexState extends AppStates {}

class ChangeThemeModeState extends AppStates {}

class SetUserSuccessState extends AppStates {}

class SetUserErrorState extends AppStates {
  String error;
  SetUserErrorState(this.error);
}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  String error;
  GetUserErrorState(this.error);
}

class UpdateUserLoadingState extends AppStates {}

class UpdateUserSuccessState extends AppStates {}

class UpdateUserErrorState extends AppStates {
  String error;
  UpdateUserErrorState(this.error);
}

class GetProfileImageSuccessState extends AppStates {}

class GetProfileImageErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class CropProfileImageSuccessState extends AppStates {}

class CropProfileImageErrorState extends AppStates {}

class GetAllUsersSuccessState extends AppStates {}

class GetAllUsersErrorState extends AppStates {
  String error;
  GetAllUsersErrorState(this.error);
}
