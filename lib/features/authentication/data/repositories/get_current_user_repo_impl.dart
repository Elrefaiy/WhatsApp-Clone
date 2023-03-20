import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/get_current_user_repo.dart';
import '../datasources/get_current_user_local.dart';
import '../datasources/get_current_user_remote.dart';

class GetCurrentUserRepositoryImpl implements GetCurrentUserRepository {
  final NetworkInfo networkInfo;
  final GetCurrentUserRemoteDataSource remoteDataSource;
  final GetCurrentUserLocalDataSource localDataSource;
  GetCurrentUserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getCurrentUser();
        await localDataSource.cacheCurrentUser(user);
        return Right(user);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final user = localDataSource.getCurrentUser();
        return Right(user);
      } catch (error) {
        return Left(CacheFailure());
      }
    }
  }
}
