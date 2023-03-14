import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_about_repo.dart';

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
        final response = await storeInstance.update(
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
