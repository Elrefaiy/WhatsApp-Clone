import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/data/models/user_model.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_otp_repo.dart';

class SubmitOTPRepositoryImpl implements SubmitOTPRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthConsumer authInstance;
  final FirebaseFirestoreConsumer storeInstance;
  final SharedPreferences sharedPreferences;

  SubmitOTPRepositoryImpl({
    required this.networkInfo,
    required this.authInstance,
    required this.storeInstance,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, dynamic>> submitOTP({
    required SubmitOTPParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: params.verificationId,
          smsCode: params.otpCode,
        );
        final response = await authInstance.signInWithCredential(
          credential: credential,
        );
        await storeInstance.set(
          collection: 'users',
          doc: authInstance.currentUser.uid,
          body: UserModel(
            name: 'User Name',
            phone: authInstance.currentUser.phoneNumber!,
            about: 'Hello, I am using Whatsapp',
            image: 'image',
            uId: authInstance.currentUser.uid,
          ).toJson(),
        );
        // sharedPreferences.setString(
        //   AppStrings.token,
        //   authInstance.currentUser.uid,
        // );
        return Right(response);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
