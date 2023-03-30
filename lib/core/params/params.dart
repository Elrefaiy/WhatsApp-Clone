import 'dart:io';

import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitPhoneParams extends Equatable {
  final String phone;
  final String country;
  final Function verificationCompleted;
  final Function verificationFailed;
  final Function codeSent;
  final Function codeAutoRetrievalTimeout;

  const SubmitPhoneParams({
    required this.phone,
    required this.country,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
  });

  @override
  List<Object?> get props {
    return [
      phone,
      country,
      verificationCompleted,
      verificationFailed,
      codeSent,
      codeAutoRetrievalTimeout,
    ];
  }
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

class GetMessagesParams extends Equatable {
  final String name;
  final String image;
  final String uId;

  const GetMessagesParams({
    required this.name,
    required this.image,
    required this.uId,
  });

  @override
  List<Object?> get props => [name, image, uId];
}

class AddTextStatusParams extends Equatable {
  final String status;
  final int color;

  const AddTextStatusParams({
    required this.status,
    required this.color,
  });

  @override
  List<Object?> get props => [status, color];
}

class ImageMessageParams extends Equatable {
  final File image;
  final String recieverId;

  const ImageMessageParams({
    required this.image,
    required this.recieverId,
  });

  @override
  List<Object?> get props => [image, recieverId];
}

class ImageStatusParams extends Equatable {
  final File image;
  final String caption;

  const ImageStatusParams({
    required this.image,
    required this.caption,
  });

  @override
  List<Object?> get props => [image, caption];
}
