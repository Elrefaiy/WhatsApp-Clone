import '../../../../../core/firebase/firebase_firestore.dart';
import '../../models/user_model.dart';

abstract class GetAllUsersRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class GetAllUsersRemoteDataSourceImpl implements GetAllUsersRemoteDataSource {
  final FirebaseFirestoreConsumer instance;
  GetAllUsersRemoteDataSourceImpl({
    required this.instance,
  });

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await instance.getAllUsers();
    List<UserModel> allUsers = [];
    for (var element in response) {
      allUsers.add(UserModel.fromJson(element));
    }
    return allUsers;
  }
}
