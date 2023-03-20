import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

abstract class SubmitOTPRepository {
  Future<Either<Failure, dynamic>> submitOTP({
    required SubmitOTPParams params,
  });
}
