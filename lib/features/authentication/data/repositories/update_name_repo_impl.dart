import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_name_repo.dart';

class UpdateUsernameReposoryImpl implements UpdateUsernameRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;

  UpdateUsernameReposoryImpl({
    required this.networkInfo,
    required this.storeInstance,
    required this.authInstance,
  });

  @override
  Future<Either<Failure, dynamic>> updateUserData({
    required String name,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storeInstance.update(
          collection: 'users',
          doc: authInstance.currentUser.uid,
          body: {
            'name': name,
          },
        );
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
