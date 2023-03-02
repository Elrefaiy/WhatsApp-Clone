import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class SubmitOTPRepository {
  Future<Either<Failure, void>> submitOTP({
    required String params,
  });
}
