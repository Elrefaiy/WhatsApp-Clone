import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitPhoneParams extends Equatable {
  final String phone;
  final String country;
  final Function verificationCompleted;

  const SubmitPhoneParams({
    required this.phone,
    required this.country,
    required this.verificationCompleted,
  });

  @override
  List<Object?> get props => [phone, country, verificationCompleted];
}

class SubmitOTPParams extends Equatable {
  final String verificationId;
  final String otpCode;

  const SubmitOTPParams({
    required this.verificationId,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [verificationId, otpCode];
}
