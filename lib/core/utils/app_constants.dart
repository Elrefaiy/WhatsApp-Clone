import 'package:flutter/material.dart';

import 'app_strings.dart';

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

  static CircleAvatar userImage({
    required double radius,
    required String image,
  }) {
    return CircleAvatar(
      radius: radius,
      child: image == 'image'
          ? const ClipOval(
              child: Image(
                image: AssetImage(AppStrings.noUserImage),
                fit: BoxFit.cover,
              ),
            )
          : ClipOval(
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  static MediaQueryData mediaQueryData(context) {
    return MediaQuery.of(context).copyWith(
      textScaleFactor: MediaQuery.of(context).size.width >= 560 ? 1.3 : 1,
    );
  }
}
