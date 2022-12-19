import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_cropper/image_cropper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late String verificationId;

  Future<void> submitPhoneNumber({
    required String phoneNumber,
    required String country,
  }) async {
    emit(SubmitPhoneNumberLoadingState());

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$country$phoneNumber',
      timeout: const Duration(seconds: 15),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    print('Verification Completed');
    await signIn(phoneAuthCredential);
  }

  void verificationFailed(error) {
    print('Verification Faild');
    emit(SubmitPhoneNumberErrorState(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(SubmitPhoneNumberSuccessState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('Code Auto Retrieval Timeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    emit(SignInLoadingState());
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      CacheHelper.putData(
        key: 'token',
        value: credential.token.toString(),
      );
      setUser();
      emit(SignInSuccessState());
    } catch (error) {
      emit(SignInErrorState(error.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    CacheHelper.removeData(key: 'token');
    await FirebaseAuth.instance.signOut();
    emit(LogoutSuccessState());
  }

  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  bool isDark = false;
  void changeMode() {
    isDark = !isDark;
    emit(ChangeThemeModeState());
  }

  late UserModel userModel;

  void setUser() {
    User currentUser = FirebaseAuth.instance.currentUser!;

    userModel = UserModel(
      name: 'username',
      phone: currentUser.phoneNumber!,
      about: 'bio ...',
      image: 'image',
      uId: currentUser.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set(
          userModel.toMap(),
        )
        .then((value) {
      emit(SetUserSuccessState());
      getUser();
    }).catchError((error) {
      emit(SetUserErrorState(error.toString()));
    });
  }

  dynamic user;

  void getUser() {
    token = CacheHelper.getData(key: 'token') ?? '';
    if (token != '') {
      User currentUser = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((value) {
        user = value.data();
        emit(GetUserSuccessState());
        // emit(SetUserSuccessState());
      }).catchError((error) {
        emit(GetUserErrorState(error.toString()));
      });
    }
  }

  void updateName({required String name}) {
    emit(UpdateUserLoadingState());
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'name': name,
    }).then((value) {
      emit(UpdateUserSuccessState());
      getUser();
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
    });
  }

  void updateAbout({required String about}) {
    emit(UpdateUserLoadingState());
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'about': about,
    }).then((value) {
      emit(UpdateUserSuccessState());
      getUser();
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
    });
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
      emit(GetProfileImageErrorState());
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
      emit(GetProfileImageErrorState());
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
          lockAspectRatio: true,
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
      profileImage = File(croppedImage.path);
      emit(CropProfileImageSuccessState());
      uploadProfilePicture();
    } else {
      print('Image not Successfully set');
      emit(CropProfileImageErrorState());
    }
  }

  void updateProfileImage({required String image}) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'image': image,
    }).then((value) {
      emit(UpdateUserSuccessState());
      getUser();
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
    });
  }

  void uploadProfilePicture() {
    User currentUser = FirebaseAuth.instance.currentUser!;
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${currentUser.uid}/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProfileImage(image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
    });
  }
}
