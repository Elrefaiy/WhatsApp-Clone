import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/update_image_repo.dart';

class UpdateUserImageUseCase implements UseCase<dynamic, File> {
  final UpdateUserImageRepository updateUserImageRepository;
  UpdateUserImageUseCase({
    required this.updateUserImageRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(File params) =>
      updateUserImageRepository.updateUserImage(image: params);
}
