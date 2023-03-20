import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/update_name_repo.dart';

class UpdateUsernameUseCase implements UseCase<dynamic, String> {
  final UpdateUsernameRepository updateUsernameRepository;
  UpdateUsernameUseCase({
    required this.updateUsernameRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(String params) =>
      updateUsernameRepository.updateUserData(name: params);
}
