import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';

abstract class GetAllUsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
}
