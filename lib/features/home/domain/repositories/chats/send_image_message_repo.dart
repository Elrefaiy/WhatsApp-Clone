import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class SendImageMessageRepository {
  Future<Either<Failure, dynamic>> sendImageMessage(
      {required String recieverId});
}
