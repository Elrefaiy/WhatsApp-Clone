import '../../../../../core/params/params.dart';
import '../../entities/message.dart';

abstract class GetChatMessagesRepository {
  Stream<List<Message>> getChatMessages({
    required GetMessagesParams params,
  });
}
