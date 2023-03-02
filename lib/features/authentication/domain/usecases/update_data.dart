import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/entities/user.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_user_repo.dart';

class UpdateUserUseCase implements UseCase<void, User> {
  final UpdateUserRepository updateUserRepository;

  UpdateUserUseCase({required this.updateUserRepository});

  @override
  Future<Either<Failure, void>> call(User params) =>
      updateUserRepository.updateUserData(user: params);
}
