import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/status.dart';
import '../../repositories/status/get_status_repo.dart';

class GetStatusUseCase
    implements UseCase<Map<String, List<Status>>, List<String>> {
  final GetStatusRepository getStatusRepository;
  GetStatusUseCase({
    required this.getStatusRepository,
  });

  @override
  Future<Either<Failure, Map<String, List<Status>>>> call(
    List<String> params,
  ) =>
      getStatusRepository.getStatus(uId: params);
}
