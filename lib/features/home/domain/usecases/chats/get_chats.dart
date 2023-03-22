import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/contact.dart';
import '../../repositories/chats/get_chats_repo.dart';

class GetChatsUseCase implements UseCase<List<Contact>, NoParams> {
  final GetChatsRepository getChatsRepository;
  GetChatsUseCase({
    required this.getChatsRepository,
  });

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) =>
      getChatsRepository.getAllChats();
}
