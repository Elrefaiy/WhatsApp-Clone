import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/repositories/status/get_status_repo.dart';
import '../../datasources/status/get_status_remote.dart';

class GetStatusRepositoryImpl implements GetStatusRepository {
  final GetStatusRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetStatusRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, List<Status>>>> getStatus({
    required List<String> uId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getStatus(uId: uId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
