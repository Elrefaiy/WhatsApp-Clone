import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/settings/domain/repositories/logout_repository.dart';

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
