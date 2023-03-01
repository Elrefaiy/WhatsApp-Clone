import 'package:flutter/material.dart';

class AppConstants {
  static showSnackBar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(
          content,
        ),
      ),
    );
  }

  static showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        ),
      ),
    );
  }

  static Image noUserImage() {
    return const Image(
      image: AssetImage(
        'assets/images/user-avatar.jpg',
      ),
      fit: BoxFit.cover,
    );
  }

  static MediaQueryData mediaQueryData(context) {
    return MediaQuery.of(context).copyWith(
      textScaleFactor: MediaQuery.of(context).size.width >= 560 ? 1.3 : 1,
    );
  }
}
