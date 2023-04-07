import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/message.dart';

abstract class GetChatMediaRepository {
  Future<Either<Failure, List<Message>>> getChatMedia({
    required String recieverId,
  });
}
