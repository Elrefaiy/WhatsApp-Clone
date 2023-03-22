import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/contact.dart';

abstract class GetChatsRepository {
  Future<Either<Failure, List<Contact>>> getAllChats();
}
