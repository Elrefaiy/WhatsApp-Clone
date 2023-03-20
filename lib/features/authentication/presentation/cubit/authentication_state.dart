part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class SubmitPhoneNumberLoadingState extends AuthenticationState {}

class SubmitPhoneNumberSuccessState extends AuthenticationState {
  final String verificationId;
  const SubmitPhoneNumberSuccessState(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}

class SubmitPhoneNumberErrorState extends AuthenticationState {
  final String error;
  const SubmitPhoneNumberErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class SignInWithCredintialLoadingState extends AuthenticationState {}

class VerificationFailedState extends AuthenticationState {
  final String error;
  const VerificationFailedState(this.error);
  @override
  List<Object> get props => [error];
}

class CodeAutoRetrievalTimeoutState extends AuthenticationState {}

class SignInLoadingState extends AuthenticationState {}

class SignInSuccessState extends AuthenticationState {}

class SignInErrorState extends AuthenticationState {
  final String error;
  const SignInErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetUserSuccessState extends AuthenticationState {
  final User user;
  const GetUserSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class GetUserErrorState extends AuthenticationState {
  final String error;
  const GetUserErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class UpdateUserLoadingState extends AuthenticationState {}

class UpdateUserSuccessState extends AuthenticationState {}

class UpdateUserErrorState extends AuthenticationState {
  final String error;
  const UpdateUserErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetProfileImageSuccessState extends AuthenticationState {}

class GetProfileImageErrorState extends AuthenticationState {
  final String error;
  const GetProfileImageErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class CropProfileImageSuccessState extends AuthenticationState {}

class CropProfileImageErrorState extends AuthenticationState {
  final String error;
  const CropProfileImageErrorState(this.error);
  @override
  List<Object> get props => [error];
}
