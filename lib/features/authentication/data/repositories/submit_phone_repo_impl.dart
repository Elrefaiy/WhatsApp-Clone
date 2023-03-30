import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/params/params.dart';
import '../../domain/repositories/submit_phone_repo.dart';

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
          verificationFailed: params.verificationFailed,
          codeSent: params.codeSent,
          codeAutoRetrievalTimeout: params.codeAutoRetrievalTimeout,
        );
        return const Right('Verification Successfully Done!');
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
