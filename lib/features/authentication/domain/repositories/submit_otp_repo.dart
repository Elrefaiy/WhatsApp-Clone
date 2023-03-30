import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';

abstract class SubmitOTPRepository {
  Future<Either<Failure, dynamic>> submitOTP({
    required SubmitOTPParams params,
  });
}
