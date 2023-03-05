import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitPhoneParams {
  final String phone;
  final String country;

  const SubmitPhoneParams({
    required this.phone,
    required this.country,
  });
}

class SubmitOTPParams {
  final String verificationId;
  final String otpCode;

  const SubmitOTPParams({
    required this.verificationId,
    required this.otpCode,
  });
}
