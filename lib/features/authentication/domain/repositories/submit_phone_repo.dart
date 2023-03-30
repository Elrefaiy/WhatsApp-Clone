import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';

abstract class SubmitPhoneRepository {
  Future<Either<Failure, String>> submitPhoneNumber({
    required SubmitPhoneParams params,
  });
}
