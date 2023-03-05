import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/entities/user.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/get_current_user_repo.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  final GetCurrentUserRepository getCurrentUserRepository;

  GetCurrentUserUseCase({required this.getCurrentUserRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      getCurrentUserRepository.getCurrentUser();
}
