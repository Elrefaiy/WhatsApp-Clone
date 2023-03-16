import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/features/home/data/models/message_model.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/send_text_message_repo.dart';

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
        return (Right(response));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
