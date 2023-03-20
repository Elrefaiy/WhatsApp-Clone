import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_phone_repo.dart';

class SubmitPhoneRepositoryImpl implements SubmitPhoneRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthConsumer instance;
  final SharedPreferences sharedPreferences;

  SubmitPhoneRepositoryImpl({
    required this.networkInfo,
    required this.sharedPreferences,
    required this.instance,
  });

  @override
  Future<Either<Failure, String>> submitPhoneNumber({
    required SubmitPhoneParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await instance.verifyPhoneNumber(
          phoneNumber: '+${params.country}${params.phone}',
          timeout: const Duration(seconds: 30),
          verificationCompleted: params.verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
        return const Right('Verification Successfully Done!');
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }

  // void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
  //   debugPrint('Verification Completed');
  //   // try {
  //   //   await instance.signInWithCredential(credential: phoneAuthCredential);
  //   //   debugPrint('SIGNING_IN_SUCCESSFULLY ${phoneAuthCredential.smsCode}');
  //   // } catch (error) {
  //   //   debugPrint('ERROR WHEN SIGNINGIN WITH CREDENTIAL');
  //   // }
  // }

  void verificationFailed(error) {
    throw VerificationException(error);
  }

  void codeSent(String verificationId, int? resendToken) async {
    await sharedPreferences.setString(
      AppStrings.verificationId,
      verificationId,
    );
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    if (verificationId.isEmpty) {
      throw const CodeAutoRetrievalTimeoutException();
    }
  }
}
