import 'package:whatsapp_clone/features/home/domain/entities/message.dart';

abstract class GetChatMessagesRepository {
  Stream<List<Message>> getChatMessages({
    required String recieverId,
  });
}
