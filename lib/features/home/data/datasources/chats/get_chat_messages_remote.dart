import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/features/home/data/models/message_model.dart';

abstract class GetChatMessagesRemoteDataSource {
  Stream<List<MessageModel>> getChatMessages(
    String receiverId,
  );
}

class GetChatMessagesRemoteDataImpl implements GetChatMessagesRemoteDataSource {
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  GetChatMessagesRemoteDataImpl({
    required this.storeInstance,
    required this.authInstance,
  });

  @override
  Stream<List<MessageModel>> getChatMessages(
    String receiverId,
  ) {
    final response = storeInstance.getChatMessages(
      uId: authInstance.currentUser.uid,
      recieverId: receiverId,
    );

    return response;
  }
}
