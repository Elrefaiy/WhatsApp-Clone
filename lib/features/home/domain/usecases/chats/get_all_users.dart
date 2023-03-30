import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/chats/get_all_users_repo.dart';

class GetAllUsersUseCase implements UseCase<List<User>, NoParams> {
  final GetAllUsersRepository getAllUsersRepository;
  GetAllUsersUseCase({
    required this.getAllUsersRepository,
  });

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      getAllUsersRepository.getAllUsers();
}
