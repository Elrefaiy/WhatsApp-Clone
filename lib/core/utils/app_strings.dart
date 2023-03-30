class AppStrings {
  static const appName = 'WhatsApp';
  static const webInitial =
      'send and receive messages without keeping your phone online.\nUse WhatsApp on up to 4 linked devices and 1 phone at the same time.';

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
  static const webDark = '$assetImages/web-dark.jpg';
  static const webLight = '$assetImages/web-light.jpg';

  //! SharedPreferences Keys
  static const verificationId = 'CACHED_VERIFICATION_ID';
  static const token = 'CACHED_USER_TOKEN';
  static const isDark = 'CACHED_IS_DARK';
  static const currentUser = 'CACHED_CURRENT_USER';
  static const allContacts = 'CACHED_ALL_CONTACTS';
}
