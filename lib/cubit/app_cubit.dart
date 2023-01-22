import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/shared/conistants/conistants.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

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
    debugPrint('Verification Completed');
    await signIn(phoneAuthCredential);
  }

  void verificationFailed(error) {
    debugPrint('Verification Faild');
    emit(SubmitPhoneNumberErrorState(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(SubmitPhoneNumberSuccessState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    debugPrint('Code Auto Retrieval Timeout');
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
      debugPrint('Image not Successfully set');
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

  List<UserModel> users = [];
  void getUsers() {
    emit(GetAllUsersLoadingState());
    if (users.isEmpty && token.isNotEmpty) {
      User currentUser = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != currentUser.uid) {
            users.add(
              UserModel.fromJson(
                element.data(),
              ),
            );
          }
        }
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }

  var chatController = ScrollController();

  void sendMessage({
    required content,
    required time,
    required date,
    required dateTime,
    required receiverId,
  }) {
    var message = MessageModel(
      message: content,
      time: time,
      date: date,
      dateTime: dateTime,
      recieverId: receiverId,
    );
    User currentUser = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(currentUser.uid)
          .collection('messages')
          .add(message.toMap())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState(error.toString()));
      });
      emit(SendMessageSuccessState());
      chatController.jumpTo(chatController.position.maxScrollExtent);
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];
  Map<String, String> lastMessages = {};
  Map<String, String> lastMessagesTime = {};
  void getChatMessages(receiverId) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      chatController.jumpTo(chatController.position.maxScrollExtent);
      for (var element in event.docs) {
        messages.add(
          MessageModel.fromJson(
            element.data(),
          ),
        );
        lastMessages.addAll({'message$receiverId': messages.last.message});
        lastMessagesTime.addAll({'time$receiverId': messages.last.time});
      }
      emit(GetChatMessagesSuccessState());
    });
    emit(GetChatMessagesSuccessState());
  }

  File messageImage = File('');

  Future<void> getMessageImage(context, receiverId) async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      cropMessageImage(context, receiverId);
      emit(GetMessageImageSuccessState());
    } else {
      emit(GetMessageImageErrorState());
    }
  }

  Future<void> cropMessageImage(context, receiverId) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarColor: Colors.black,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
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
      messageImage = File(croppedImage.path);
      emit(CropMessageImageSuccessState());
      uploadMessageImage(receiverId);
    } else {
      debugPrint('Image not Successfully set');
      emit(CropMessageImageErrorState());
    }
  }

  void uploadMessageImage(receiverId) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    emit(UploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'media/${currentUser.uid}/${Uri.file(messageImage.path).pathSegments.last}')
        .putFile(messageImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          content: value,
          time: DateTime.now().toString().substring(11, 16),
          date: DateFormat.yMMMd().format(DateTime.now()).toString(),
          dateTime: DateTime.now().toString(),
          receiverId: receiverId,
        );
      }).catchError((error) {
        emit(UploadMessageImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadMessageImageErrorState());
    });
  }
}
