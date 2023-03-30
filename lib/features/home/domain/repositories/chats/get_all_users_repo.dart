import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/user.dart';

abstract class GetAllUsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
}
