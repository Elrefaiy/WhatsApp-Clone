class AppStrings {
  static const appName = 'WhatsApp';

  //! Failure Messages
  static const loginWarning =
      'you have logged in more than many times in short time, you have to wait few minutes before you login again.';
  static const somethingWrong = 'some thing went wrong, please try again';
  static const serverFailure = 'There is a Failure Occured, on Server';
  static const cacheFailure = 'There is a Failure Occured, on Cache';

  //! Assets
  static const assetImages = 'assets/images';
  static const noUserImage = '$assetImages/user-avatar.jpg';
  static const chatDark = '$assetImages/chat-dark.jpg';
  static const chatLight = '$assetImages/chat-light.jpg';

  //! SharedPreferences Keys
  static const verificationId = 'CACHED_VERIFICATION_ID';
  static const token = 'USER_TOKEN';
  static const isDark = 'IS_DARK';
}
