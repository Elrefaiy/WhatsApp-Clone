import '../../../../../core/params/params.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chats/get_chat_messages_repo.dart';
import '../../datasources/chats/get_chat_messages_remote.dart';

class GetChatMessagesRepositoryImpl implements GetChatMessagesRepository {
  final GetChatMessagesRemoteDataSource remoteDataSource;

  GetChatMessagesRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Stream<List<Message>> getChatMessages({
    required GetMessagesParams params,
  }) {
    return remoteDataSource.getChatMessages(params);
  }
}
