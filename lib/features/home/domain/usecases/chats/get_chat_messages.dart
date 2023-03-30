import '../../../../../core/params/params.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../entities/message.dart';
import '../../repositories/chats/get_chat_messages_repo.dart';

class GetChatMessagesUseCase
    implements StreamUseCase<List<Message>, GetMessagesParams> {
  final GetChatMessagesRepository getChatMessagesRepository;
  GetChatMessagesUseCase({
    required this.getChatMessagesRepository,
  });

  @override
  Stream<List<Message>> call(GetMessagesParams params) =>
      getChatMessagesRepository.getChatMessages(params: params);
}
