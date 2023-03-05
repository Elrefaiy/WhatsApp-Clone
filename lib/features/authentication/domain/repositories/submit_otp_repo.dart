import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';

abstract class SubmitOTPRepository {
  Future<Either<Failure, dynamic>> submitOTP({
    required SubmitOTPParams params,
  });
}
