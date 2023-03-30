import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repositories/chats/send_image_message_repo.dart';

class SendImageMessageUseCase implements UseCase<dynamic, ImageMessageParams> {
  final SendImageMessageRepository sendImageMessageRepository;
  SendImageMessageUseCase({
    required this.sendImageMessageRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(ImageMessageParams params) =>
      sendImageMessageRepository.sendImageMessage(params: params);
}
