import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class GetCurrentUserRepository {
  Future<Either<Failure, User>> getCurrentUser();
}
