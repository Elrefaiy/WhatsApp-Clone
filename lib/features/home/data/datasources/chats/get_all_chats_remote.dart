import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';

import '../../../../../core/firebase/firebase_firestore.dart';
import '../../models/contact_model.dart';

abstract class GetAllChatsRemoteDataSource {
  Future<List<ContactModel>> getAllchats();
}

class GetAllChatsRemoteDataSourceImpl implements GetAllChatsRemoteDataSource {
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  GetAllChatsRemoteDataSourceImpl({
    required this.storeInstance,
    required this.authInstance,
  });

  @override
  Future<List<ContactModel>> getAllchats() {
    final response = storeInstance.getAllChats(
      uId: authInstance.currentUser.uid,
    );
    return response;
  }
}
