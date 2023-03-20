import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/submit_otp_repo.dart';

class SubmitOTPUseCase implements UseCase<dynamic, SubmitOTPParams> {
  final SubmitOTPRepository submitOTPRepository;
  SubmitOTPUseCase({
    required this.submitOTPRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(SubmitOTPParams params) =>
      submitOTPRepository.submitOTP(params: params);
}
