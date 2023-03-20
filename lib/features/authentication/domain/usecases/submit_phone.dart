import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/submit_phone_repo.dart';

class SubmitPhoneUseCase implements UseCase<String, SubmitPhoneParams> {
  final SubmitPhoneRepository submitPhoneRepository;
  SubmitPhoneUseCase({
    required this.submitPhoneRepository,
  });

  @override
  Future<Either<Failure, String>> call(SubmitPhoneParams params) =>
      submitPhoneRepository.submitPhoneNumber(params: params);
}
