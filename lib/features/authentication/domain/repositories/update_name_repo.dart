import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class UpdateUsernameRepository {
  Future<Either<Failure, dynamic>> updateUserData({
    required String name,
  });
}
