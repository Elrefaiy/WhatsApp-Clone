import 'package:flutter/material.dart';

SnackBar snackBar({required String content}) => SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        content,
      ),
    );

showLoadingDialog(context) {
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
