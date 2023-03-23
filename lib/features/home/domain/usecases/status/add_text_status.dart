import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repositories/status/add_text_status_repo.dart';

class AddTextStatusUseCase implements UseCase<dynamic, AddTextStatusParams> {
  final AddTextStatusRepository addTextStatusRepository;
  AddTextStatusUseCase({
    required this.addTextStatusRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(AddTextStatusParams params) =>
      addTextStatusRepository.addTextStatus(params: params);
}
