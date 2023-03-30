import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';

abstract class AddImageStatusRepository {
  Future<Either<Failure, dynamic>> addImageStatus({
    required ImageStatusParams params,
  });
}
