import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/features/home/data/models/contact_model.dart';

abstract class GetAllChatsRemoteDataSource {
  Stream<List<ContactModel>> getAllchats();
}

class GetAllChatsRemoteDataSourceImpl implements GetAllChatsRemoteDataSource {
  final FirebaseFirestoreConsumer storeConsumer;

  GetAllChatsRemoteDataSourceImpl({required this.storeConsumer});

  @override
  Stream<List<ContactModel>> getAllchats() {
    throw UnimplementedError();
  }
}

// users -> currentUserId -> chats -> reciever['contact']