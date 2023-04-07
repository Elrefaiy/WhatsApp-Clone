import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/message.dart';
import '../../repositories/chats/get_chat_media_repo.dart';

class GetChatMediaUseCase implements UseCase<List<Message>, String> {
  final GetChatMediaRepository getChatMediaRepository;
  GetChatMediaUseCase({
    required this.getChatMediaRepository,
  });

  @override
  Future<Either<Failure, List<Message>>> call(String params) {
    return getChatMediaRepository.getChatMedia(
      recieverId: params,
    );
  }
}
