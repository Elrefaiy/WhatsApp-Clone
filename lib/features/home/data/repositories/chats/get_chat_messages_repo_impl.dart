import 'package:whatsapp_clone/features/home/data/datasources/chats/get_chat_messages_remote.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_chat_messages_repo.dart';

class GetChatMessagesRepositoryImpl implements GetChatMessagesRepository {
  final GetChatMessagesRemoteDataSource remoteDataSource;

  GetChatMessagesRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Stream<List<Message>> getChatMessages({
    required String recieverId,
  }) {
    return remoteDataSource.getChatMessages(recieverId);
  }
}
