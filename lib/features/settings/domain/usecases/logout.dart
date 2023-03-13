import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/settings/domain/repositories/logout_repository.dart';

class LogoutUseCase implements UseCase<dynamic, NoParams> {
  final LogoutRepository logoutRepository;
  LogoutUseCase({required this.logoutRepository});

  @override
  Future<Either<Failure, dynamic>> call(NoParams params) =>
      logoutRepository.logout();
}
