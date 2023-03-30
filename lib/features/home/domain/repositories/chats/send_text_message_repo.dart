import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/message.dart';

abstract class SendTextMessageRepository {
  Future<Either<Failure, dynamic>> sendTextMessage({
    required Message message,
  });
}
