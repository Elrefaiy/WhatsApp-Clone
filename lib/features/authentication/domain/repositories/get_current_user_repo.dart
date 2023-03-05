import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/features/authentication/domain/entities/user.dart';

abstract class GetCurrentUserRepository {
  Future<Either<Failure, User>> getCurrentUser();
}
