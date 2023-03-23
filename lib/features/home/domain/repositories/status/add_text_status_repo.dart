import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';

abstract class AddTextStatusRepository {
  Future<Either<Failure, dynamic>> addTextStatus({
    required AddTextStatusParams params,
  });
}
