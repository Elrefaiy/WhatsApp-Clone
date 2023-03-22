import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/firebase/firebase_firestore.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../models/contact_model.dart';
import '../../models/message_model.dart';

abstract class GetChatMessagesRemoteDataSource {
  Stream<List<MessageModel>> getChatMessages(
    GetMessagesParams params,
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
    GetMessagesParams params,
  ) {
    final response = storeInstance.getChatMessages(
      uId: authInstance.currentUser.uid,
      recieverId: params.uId,
    );
    response.listen((event) async {
      if (event.length == 1) {
        await storeInstance.setContact(
          uId: authInstance.currentUser.uid,
          reciverId: params.uId,
          body: ContactModel(
            name: params.name,
            image: params.image,
            lastMessage: event[0].message,
            dateTime: event[0].dateTime,
            uId: params.uId,
          ).toJson(),
        );
      }
    });
    return response;
  }
}
