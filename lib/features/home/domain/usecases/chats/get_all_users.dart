import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_all_users_repo.dart';

class GetAllUsersUseCase implements UseCase<List<User>, NoParams> {
  final GetAllUsersRepository getAllUsersRepository;

  GetAllUsersUseCase({required this.getAllUsersRepository});
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      getAllUsersRepository.getAllUsers();
}
