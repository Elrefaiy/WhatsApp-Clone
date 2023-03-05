import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/features/authentication/data/models/user_model.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/get_current_user_repo.dart';

class GetCurrentUserRepositoryImpl implements GetCurrentUserRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthConsumer authInstance;
  final FirebaseFirestoreConsumer storeInstance;

  GetCurrentUserRepositoryImpl({
    required this.networkInfo,
    required this.authInstance,
    required this.storeInstance,
  });

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        final json = await storeInstance.getUser(
          uId: authInstance.currentUser.uid,
        );
        final user = UserModel.fromJson(json);
        return Right(user);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
