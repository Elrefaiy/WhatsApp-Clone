import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/send_text_message_repo.dart';

class SendTextMessageUseCase implements UseCase<dynamic, Message> {
  final SendTextMessageRepository sendTextMessageRepository;

  SendTextMessageUseCase({required this.sendTextMessageRepository});
  @override
  Future<Either<Failure, dynamic>> call(Message params) =>
      sendTextMessageRepository.sendTextMessage(message: params);
}
