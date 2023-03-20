import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/firebase/firebase_firestore.dart';
import '../../../../core/firebase/firebase_storage.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/update_image_repo.dart';

class UpdateUserImageRepositoryImpl implements UpdateUserImageRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  final FirebaseStorageConsumer storageInstance;
  UpdateUserImageRepositoryImpl({
    required this.networkInfo,
    required this.storeInstance,
    required this.storageInstance,
    required this.authInstance,
  });

  @override
  Future<Either<Failure, dynamic>> updateUserImage({
    required File image,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storageInstance.upload(
          path:
              'users/${authInstance.currentUser.uid}/${Uri.file(image.path).pathSegments.last}',
          file: image,
          function: (value) {
            storeInstance.updateUserData(
              collection: 'users',
              doc: authInstance.currentUser.uid,
              body: {
                'image': value,
              },
            );
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
