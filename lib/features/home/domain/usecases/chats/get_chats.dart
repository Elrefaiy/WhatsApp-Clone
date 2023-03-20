import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/home/domain/entities/contact.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_chats_repo.dart';

class GetChatsUseCase implements StreamUseCase<List<Contact>, NoParams> {
  final GetChatsRepository getChatsRepository;

  GetChatsUseCase({required this.getChatsRepository});

  @override
  Stream<List<Contact>> call(NoParams params) =>
      getChatsRepository.getAllChats();
}
