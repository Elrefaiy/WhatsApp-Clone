import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/firebase/firebase_storage.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/params/params.dart';
import '../../../domain/repositories/status/add_image_status_repo.dart';
import '../../models/status_model.dart';

class AddImageStatusRepositoryImpl implements AddImageStatusRepository {
  final FirebaseStorageConsumer storageInstance;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  final NetworkInfo networkInfo;
  AddImageStatusRepositoryImpl({
    required this.storageInstance,
    required this.storeInstance,
    required this.authInstance,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> addImageStatus({
    required ImageStatusParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storageInstance.upload(
          file: params.image,
          path:
              'status/${authInstance.currentUser.uid}/${Uri.file(params.image.path).pathSegments.last}',
          function: (value) {
            storeInstance.addStatus(
              uId: authInstance.currentUser.uid,
              body: StatusModel(
                status: value,
                caption: params.caption,
                dateTime: DateTime.now().toString(),
                isImage: true,
                color: 0,
              ).toJson(),
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
