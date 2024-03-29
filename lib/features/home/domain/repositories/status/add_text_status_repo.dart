import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';

abstract class AddTextStatusRepository {
  Future<Either<Failure, dynamic>> addTextStatus({
    required AddTextStatusParams params,
  });
}
