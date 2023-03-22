import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/firebase/firebase_auth.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/repositories/chats/get_chats_repo.dart';
import '../../datasources/chats/get_all_chats_remote.dart';

class GetChatsRepositoryImpl implements GetChatsRepository {
  final GetAllChatsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetChatsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Contact>>> getAllChats() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAllchats();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw Exception();
    }
  }
}
