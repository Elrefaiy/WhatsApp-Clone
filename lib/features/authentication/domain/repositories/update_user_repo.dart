import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/features/authentication/domain/entities/user.dart';

abstract class UpdateUserRepository {
  Future<Either<Failure, void>> updateUserData({required User user});
}
