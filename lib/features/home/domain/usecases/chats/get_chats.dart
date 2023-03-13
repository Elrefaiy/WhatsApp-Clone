import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_chats_repo.dart';

class GetChatsUseCase implements UseCase<List<User>, NoParams> {
  final GetChatsRepository getChatsRepository;

  GetChatsUseCase({required this.getChatsRepository});
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      getChatsRepository.getAllChats();
}
