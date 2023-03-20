import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/get_current_user_repo.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  final GetCurrentUserRepository getCurrentUserRepository;
  GetCurrentUserUseCase({
    required this.getCurrentUserRepository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      getCurrentUserRepository.getCurrentUser();
}
