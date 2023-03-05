import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/get_current_users.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/submit_otp.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/submit_phone.dart';
import '../../domain/entities/user.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SubmitPhoneUseCase submitPhoneUseCase;
  final SubmitOTPUseCase submitOTPUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SharedPreferences sharedPreferences;

  AuthenticationCubit({
    required this.submitPhoneUseCase,
    required this.submitOTPUseCase,
    required this.getCurrentUserUseCase,
    required this.sharedPreferences,
  }) : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  Future<void> submitPhoneNumber({
    required String phone,
    required String country,
  }) async {
    emit(SubmitPhoneNumberLoadingState());
    SubmitPhoneParams params = SubmitPhoneParams(
      phone: phone,
      country: country,
    );
    final response = await submitPhoneUseCase(params);

    response.fold(
      (failure) => emit(SubmitPhoneNumberErrorState(_mapFailureToMsg(failure))),
      (verificationMsg) {
        emit(SubmitPhoneNumberSuccessState(verificationMsg));
      },
    );
  }

  late User currentUser;

  Future<void> submitOTP({
    required String otpCode,
  }) async {
    emit(SignInLoadingState());
    SubmitOTPParams params = SubmitOTPParams(
      otpCode: otpCode,
      verificationId: sharedPreferences.getString(AppStrings.verificationId)!,
    );
    final response = await submitOTPUseCase(params);
    response.fold(
      (failure) => emit(SignInErrorState(_mapFailureToMsg(failure))),
      (right) {
        emit(SignInSuccessState());
        getCurrentUser();
      },
    );
  }

  Future<void> getCurrentUser() async {
    final response = await getCurrentUserUseCase(NoParams());
    emit(
      response.fold(
        (failure) => GetUserErrorState(_mapFailureToMsg(failure)),
        (user) => GetUserSuccessState(user),
      ),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.somethingWrong;
    }
  }
}
