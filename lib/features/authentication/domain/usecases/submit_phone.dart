import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_phone_repo.dart';

class SubmitPhoneUseCase implements UseCase<void, SubmitPhoneParams> {
  final SubmitPhoneRepository submitPhoneRepository;
  SubmitPhoneUseCase({required this.submitPhoneRepository});

  @override
  Future<Either<Failure, void>> call(SubmitPhoneParams params) =>
      submitPhoneRepository.submitPhoneNumber(params: params);
}
