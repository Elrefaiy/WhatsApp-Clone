import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/update_about_repo.dart';

class UpdateAboutUseCase implements UseCase<dynamic, String> {
  final UpdateAboutRepository updateAboutRepository;
  UpdateAboutUseCase({
    required this.updateAboutRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(String params) =>
      updateAboutRepository.updateAbout(about: params);
}
