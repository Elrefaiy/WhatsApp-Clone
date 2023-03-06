import 'dart:io';

import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_image_repo.dart';

class UpdateUserImageUseCase implements UseCase<dynamic, File> {
  final UpdateUserImageRepository updateUserImageRepository;

  UpdateUserImageUseCase({required this.updateUserImageRepository});
  @override
  Future<Either<Failure, dynamic>> call(File params) =>
      updateUserImageRepository.updateUserImage(image: params);
}
