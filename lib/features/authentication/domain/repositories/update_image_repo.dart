import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class UpdateUserImageRepository {
  Future<Either<Failure, dynamic>> updateUserImage({required File image});
}
