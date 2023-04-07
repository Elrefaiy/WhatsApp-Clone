import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/firebase/firebase_storage.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/params/params.dart';
import '../../../domain/repositories/chats/send_image_message_repo.dart';
import '../../models/message_model.dart';

class SendImageMessageRepositoryImpl implements SendImageMessageRepository {
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseStorageConsumer storageInstance;
  final FirebaseAuthConsumer authInstance;
  final NetworkInfo networkInfo;
  SendImageMessageRepositoryImpl({
    required this.storeInstance,
    required this.storageInstance,
    required this.authInstance,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> sendImageMessage({
    required ImageMessageParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storageInstance.upload(
          file: params.image,
          path:
              'media/${authInstance.currentUser.uid}_to_${params.recieverId}/${Uri.file(params.image.path).pathSegments.last}',
          function: (value) {
            storeInstance.addMessage(
              collection1: 'users',
              doc1: authInstance.currentUser.uid,
              collection2: 'chats',
              doc2: params.recieverId,
              collection3: 'messages',
              body: MessageModel(
                message: value,
                time: DateTime.now().toString().substring(11, 16),
                date: DateFormat.yMMMd().format(DateTime.now()).toString(),
                dateTime: DateTime.now().toString(),
                recieverId: params.recieverId,
              ).toJson(),
            );
            storeInstance.addMessage(
              collection1: 'users',
              doc1: authInstance.currentUser.uid,
              collection2: 'chats',
              doc2: params.recieverId,
              collection3: 'media',
              body: MessageModel(
                message: value,
                time: DateTime.now().toString().substring(11, 16),
                date: DateFormat.yMMMd().format(DateTime.now()).toString(),
                dateTime: DateTime.now().toString(),
                recieverId: params.recieverId,
              ).toJson(),
            );
          },
        );
        await storeInstance.updateContactData(
          uId: authInstance.currentUser.uid,
          reciverId: params.recieverId,
          body: {
            'lastMessage': 'Picture',
            'dateTime': DateTime.now().toString(),
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
