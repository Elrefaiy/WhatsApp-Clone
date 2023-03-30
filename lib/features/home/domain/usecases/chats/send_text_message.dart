import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/message.dart';
import '../../repositories/chats/send_text_message_repo.dart';

class SendTextMessageUseCase implements UseCase<dynamic, Message> {
  final SendTextMessageRepository sendTextMessageRepository;
  SendTextMessageUseCase({
    required this.sendTextMessageRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(Message params) =>
      sendTextMessageRepository.sendTextMessage(message: params);
}
