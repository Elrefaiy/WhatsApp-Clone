import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';

abstract class GetChatMessagesRepository {
  Stream<List<Message>> getChatMessages({
    required GetMessagesParams params,
  });
}
