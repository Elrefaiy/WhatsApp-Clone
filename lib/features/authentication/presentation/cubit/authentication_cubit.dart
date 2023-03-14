import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/get_current_users.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/submit_otp.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/submit_phone.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_about.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_image.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_name.dart';
import '../../domain/entities/user.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SubmitPhoneUseCase submitPhoneUseCase;
  final SubmitOTPUseCase submitOTPUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdateUsernameUseCase updateUsernameUseCase;
  final UpdateUserImageUseCase updateUserImageUseCase;
  final UpdateAboutUseCase updateAboutUseCase;
  final SharedPreferences sharedPreferences;

  AuthenticationCubit({
    required this.submitPhoneUseCase,
    required this.submitOTPUseCase,
    required this.getCurrentUserUseCase,
    required this.updateUsernameUseCase,
    required this.updateUserImageUseCase,
    required this.updateAboutUseCase,
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
    final params = SubmitOTPParams(
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
    response.fold(
      (failure) => emit(GetUserErrorState(_mapFailureToMsg(failure))),
      (user) {
        currentUser = user;
        emit(GetUserSuccessState(user));
      },
    );
  }

  Future<void> updateUsername({
    required String username,
  }) async {
    emit(UpdateUserLoadingState());
    final response = await updateUsernameUseCase(username);
    response.fold(
      (failure) => emit(UpdateUserErrorState(_mapFailureToMsg(failure))),
      (right) {
        emit(UpdateUserSuccessState());
        getCurrentUser();
      },
    );
  }

  Future<void> updateAbout({
    required String about,
  }) async {
    emit(UpdateUserLoadingState());
    final response = await updateAboutUseCase(about);

    response.fold(
      (failure) => emit(UpdateUserErrorState(_mapFailureToMsg(failure))),
      (right) {
        emit(UpdateUserSuccessState());
        getCurrentUser();
      },
    );
  }

  File profileImage = File('');
  ImagePicker picker = ImagePicker();
  dynamic pickedFile;

  Future<void> getGalleryImage(context) async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      cropImage(context);
      emit(GetProfileImageSuccessState());
    } else {
      emit(const GetProfileImageErrorState('No Image Selected'));
    }
  }

  Future<void> getCameraImage(context) async {
    pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      cropImage(context);
      emit(GetProfileImageSuccessState());
    } else {
      emit(const GetProfileImageErrorState('No Image Captured'));
    }
  }

  Future<void> cropImage(context) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarColor: Colors.black,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedImage != null) {
      emit(UpdateUserLoadingState());
      profileImage = File(croppedImage.path);
      emit(CropProfileImageSuccessState());
      final response = await updateUserImageUseCase(profileImage);

      response.fold(
        (failure) => emit(UpdateUserErrorState(_mapFailureToMsg(failure))),
        (right) {
          emit(UpdateUserSuccessState());
          getCurrentUser();
        },
      );
    } else {
      emit(const CropProfileImageErrorState('Image is not Cropped'));
    }
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
