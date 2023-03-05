import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_otp_repo.dart';

class SubmitOTPUseCase implements UseCase<dynamic, SubmitOTPParams> {
  final SubmitOTPRepository submitOTPRepository;
  SubmitOTPUseCase({required this.submitOTPRepository});

  @override
  Future<Either<Failure, dynamic>> call(SubmitOTPParams params) =>
      submitOTPRepository.submitOTP(params: params);
}
