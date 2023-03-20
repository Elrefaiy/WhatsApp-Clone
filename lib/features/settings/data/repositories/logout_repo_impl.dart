import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthConsumer authInstance;
  final SharedPreferences sharedPreferences;
  LogoutRepositoryImpl({
    required this.networkInfo,
    required this.authInstance,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, dynamic>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authInstance.signOut();
        await sharedPreferences.remove(AppStrings.token);
        return (Right(response));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
