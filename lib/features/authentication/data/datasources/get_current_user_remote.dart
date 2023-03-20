import '../../../../core/firebase/firebase_auth.dart';
import '../../../../core/firebase/firebase_firestore.dart';
import '../models/user_model.dart';

abstract class GetCurrentUserRemoteDataSource {
  Future<UserModel> getCurrentUser();
}

class GetCurrentUserRemoteDataImpl implements GetCurrentUserRemoteDataSource {
  final FirebaseAuthConsumer authInstance;
  final FirebaseFirestoreConsumer storeInstance;
  GetCurrentUserRemoteDataImpl({
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
