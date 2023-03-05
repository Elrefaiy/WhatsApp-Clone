import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';

abstract class SubmitPhoneRepository {
  Future<Either<Failure, String>> submitPhoneNumber({
    required SubmitPhoneParams params,
  });
}
