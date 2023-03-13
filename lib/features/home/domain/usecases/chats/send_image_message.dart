import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/send_image_message_repo.dart';

class SendImageMessageUseCase implements UseCase<dynamic, String> {
  final SendImageMessageRepository sendImageMessageRepository;
  SendImageMessageUseCase({required this.sendImageMessageRepository});

  @override
  Future<Either<Failure, dynamic>> call(String params) =>
      sendImageMessageRepository.sendImageMessage(recieverId: params);
}
