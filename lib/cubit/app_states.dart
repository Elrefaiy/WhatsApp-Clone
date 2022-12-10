abstract class AppStates {}

class AppInitialState extends AppStates {}

class UserLoginLoadingState extends AppStates {}

class UserLoginSuccessState extends AppStates {}

class UserLoginErrorState extends AppStates {
  String error;
  UserLoginErrorState(this.error);
}
