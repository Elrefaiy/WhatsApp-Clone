import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chats/send_text_message_repo.dart';

class SendTextMessageRepositoryImpl implements SendTextMessageRepository {
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  final NetworkInfo networkInfo;

  SendTextMessageRepositoryImpl({
    required this.storeInstance,
    required this.authInstance,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> sendTextMessage({
    required Message message,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storeInstance.addMessage(
          collection1: 'users',
          doc1: authInstance.currentUser.uid,
          collection2: 'chats',
          doc2: message.recieverId,
          collection3: 'messages',
          body: message.toMap(),
        );
        await storeInstance.updateContactData(
          uId: authInstance.currentUser.uid,
          reciverId: message.recieverId,
          body: {
            'lastMessage': message.message,
            'dateTime': message.dateTime,
          },
        );
        return (Right(response));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
