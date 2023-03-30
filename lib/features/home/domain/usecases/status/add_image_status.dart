import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/params/params.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repositories/status/add_image_status_repo.dart';

class AddImageStatusUseCase implements UseCase<dynamic, ImageStatusParams> {
  final AddImageStatusRepository addImageStatusRepository;
  AddImageStatusUseCase({
    required this.addImageStatusRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(ImageStatusParams params) {
    return addImageStatusRepository.addImageStatus(params: params);
  }
}
