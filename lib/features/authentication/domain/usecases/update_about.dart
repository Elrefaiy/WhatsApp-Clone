import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_about_repo.dart';

class UpdateAboutUseCase implements UseCase<dynamic, String> {
  final UpdateAboutRepository updateAboutRepository;

  UpdateAboutUseCase({required this.updateAboutRepository});

  @override
  Future<Either<Failure, dynamic>> call(String params) =>
      updateAboutRepository.updateAbout(about: params);
}
