import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';

abstract class SendTextMessageRepository {
  Future<Either<Failure, dynamic>> sendTextMessage({required Message message});
}
