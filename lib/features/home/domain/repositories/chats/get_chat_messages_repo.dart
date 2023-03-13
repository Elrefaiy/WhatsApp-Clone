import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';

abstract class GetChatMessagesRepository {
  Future<Either<Failure, List<Message>>> getChatMessages({
    required String recieverId,
  });
}
