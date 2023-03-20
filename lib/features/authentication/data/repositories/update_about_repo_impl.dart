import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/firebase/firebase_firestore.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/update_about_repo.dart';

class UpdateAboutReposoryImpl implements UpdateAboutRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;

  UpdateAboutReposoryImpl({
    required this.networkInfo,
    required this.storeInstance,
    required this.authInstance,
  });

  @override
  Future<Either<Failure, dynamic>> updateAbout({
    required String about,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storeInstance.updateUserData(
          collection: 'users',
          doc: authInstance.currentUser.uid,
          body: {
            'about': about,
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
