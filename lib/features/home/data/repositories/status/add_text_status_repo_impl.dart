import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/home/data/models/status_model.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/repositories/status/add_text_status_repo.dart';

class AddTextStatusRepositoryImpl implements AddTextStatusRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  AddTextStatusRepositoryImpl({
    required this.networkInfo,
    required this.storeInstance,
    required this.authInstance,
  });

  @override
  Future<Either<Failure, dynamic>> addTextStatus({
    required AddTextStatusParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storeInstance.addStatus(
          uId: authInstance.currentUser.uid,
          body: StatusModel(
            status: params.status,
            caption: 'No Caption',
            dateTime: DateTime.now().toString(),
            isImage: false,
            color: params.color,
          ).toJson(),
        );
        return (Right(response));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
