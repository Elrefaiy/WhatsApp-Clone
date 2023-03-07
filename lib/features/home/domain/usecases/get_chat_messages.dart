import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/get_chat_messages_repo.dart';

class GetChatMessagesUseCase implements UseCase<List<Message>, String> {
  final GetChatMessagesRepository getChatMessagesRepository;
  GetChatMessagesUseCase({required this.getChatMessagesRepository});

  @override
  Future<Either<Failure, List<Message>>> call(String params) =>
      getChatMessagesRepository.getChatMessages(recieverId: params);
}
