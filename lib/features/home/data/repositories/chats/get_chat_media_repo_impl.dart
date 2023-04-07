import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chats/get_chat_media_repo.dart';

class GetChatMediaRepositoryImpl implements GetChatMediaRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthConsumer authInstance;
  final FirebaseFirestoreConsumer storeInstance;

  GetChatMediaRepositoryImpl({
    required this.networkInfo,
    required this.authInstance,
    required this.storeInstance,
  });

  @override
  Future<Either<Failure, List<Message>>> getChatMedia({
    required String recieverId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storeInstance.getChatMedia(
          uId: authInstance.currentUser.uid,
          recieverId: recieverId,
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
