import 'package:whatsapp_clone/features/home/domain/entities/contact.dart';

abstract class GetChatsRepository {
  Stream<List<Contact>> getAllChats();
}
