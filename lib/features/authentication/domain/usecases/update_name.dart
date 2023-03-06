import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_name_repo.dart';

class UpdateUsernameUseCase implements UseCase<dynamic, String> {
  final UpdateUsernameRepository updateUsernameRepository;

  UpdateUsernameUseCase({required this.updateUsernameRepository});

  @override
  Future<Either<Failure, dynamic>> call(String params) =>
      updateUsernameRepository.updateUserData(name: params);
}
