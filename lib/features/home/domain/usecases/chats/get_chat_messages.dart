import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_chat_messages_repo.dart';

class GetChatMessagesUseCase implements StreamUseCase<List<Message>, String> {
  final GetChatMessagesRepository getChatMessagesRepository;
  GetChatMessagesUseCase({required this.getChatMessagesRepository});

  @override
  Stream<List<Message>> call(String params) =>
      getChatMessagesRepository.getChatMessages(recieverId: params);
}
