import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class UpdateAboutRepository {
  Future<Either<Failure, dynamic>> updateAbout({
    required String about,
  });
}
