import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/firebase/firebase_firestore.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/submit_otp_repo.dart';

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
        await storeInstance.setUser(
          uId: authInstance.currentUser.uid,
          phone: authInstance.currentUser.phoneNumber!,
        );
        sharedPreferences.setString(
          AppStrings.token,
          authInstance.currentUser.uid,
        );
        return Right(response);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
