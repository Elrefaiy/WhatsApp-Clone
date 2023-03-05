import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;
  const ServerException([this.message]);
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    return '$message';
  }
}

class CacheException extends Equatable implements Exception {
  final String? message;
  const CacheException([this.message]);
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    return '$message';
  }
}

class RoutesException extends Equatable implements Exception {
  final String? message;
  const RoutesException([this.message]);
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    return '$message';
  }
}

class VerificationException extends ServerException {
  const VerificationException([message]) : super("Verification Phone Failed");
}

class NoVerificationIdException extends ServerException {
  const NoVerificationIdException([message])
      : super("No Verification Id Recieved");
}

class CodeAutoRetrievalTimeoutException extends ServerException {
  const CodeAutoRetrievalTimeoutException([message])
      : super("Code Auto Retrieval Timeout");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}
