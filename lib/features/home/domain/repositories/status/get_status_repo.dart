import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/status.dart';

abstract class GetStatusRepository {
  Future<Either<Failure, Map<String, List<Status>>>> getStatus({
    required List<String> uId,
  });
}
