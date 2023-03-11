import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/features/home/data/datasources/get_all_users_remote.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/get_all_users_repo.dart';

class GetAllUsersRepositroyImpl implements GetAllUsersRepository {
  final GetAllUsersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetAllUsersRepositroyImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final allUsers = await remoteDataSource.getAllUsers();
        return Right(allUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
