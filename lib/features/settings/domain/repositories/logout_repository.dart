import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class LogoutRepository {
  Future<Either<Failure, dynamic>> logout();
}
