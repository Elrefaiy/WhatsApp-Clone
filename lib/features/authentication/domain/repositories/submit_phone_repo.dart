import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

abstract class SubmitPhoneRepository {
  Future<Either<Failure, String>> submitPhoneNumber({
    required SubmitPhoneParams params,
  });
}
