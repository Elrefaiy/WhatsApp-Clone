import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/features/home/data/datasources/get_all_users_local.dart';
import 'package:whatsapp_clone/features/home/data/datasources/get_all_users_remote.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_all_users_repo.dart';

class GetAllUsersRepositroyImpl implements GetAllUsersRepository {
  final GetAllUsersRemoteDataSource remoteDataSource;
  final GetAllUsersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GetAllUsersRepositroyImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final allUsers = await remoteDataSource.getAllUsers();
        await localDataSource.cacheUsers(allUsers);
        return Right(allUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final allUsers = localDataSource.getAllUsers();
        return Right(allUsers);
      } on ServerException {
        return Left(CacheFailure());
      }
    }
  }
}
