import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';

abstract class SendImageMessageRepository {
  Future<Either<Failure, dynamic>> sendImageMessage({
    required ImageMessageParams params,
  });
}
