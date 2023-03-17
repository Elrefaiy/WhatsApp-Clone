import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/features/authentication/data/models/user_model.dart';

abstract class GetCurrentUserRemoteDataSource {
  Future<UserModel> getCurrentUser();
}

class GetCurrentUserRemoteDataSourceImpl
    implements GetCurrentUserRemoteDataSource {
  final FirebaseAuthConsumer authInstance;
  final FirebaseFirestoreConsumer storeInstance;

  GetCurrentUserRemoteDataSourceImpl({
    required this.authInstance,
    required this.storeInstance,
  });
  @override
  Future<UserModel> getCurrentUser() async {
    final json = await storeInstance.getUser(
      uId: authInstance.currentUser.uid,
    );
    return UserModel.fromJson(json);
  }
}
