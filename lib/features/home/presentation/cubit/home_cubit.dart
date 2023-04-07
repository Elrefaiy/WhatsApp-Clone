import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/get_chat_media.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/status.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/chats/get_all_users.dart';
import '../../domain/usecases/chats/get_chat_messages.dart';
import '../../domain/usecases/chats/get_chats.dart';
import '../../domain/usecases/chats/send_image_message.dart';
import '../../domain/usecases/chats/send_text_message.dart';
import '../../domain/usecases/status/add_image_status.dart';
import '../../domain/usecases/status/add_text_status.dart';
import '../../domain/usecases/status/get_status.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetChatsUseCase getChatsUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final AddTextStatusUseCase addTextStatusUseCase;
  final GetStatusUseCase getStatusUseCase;
  final SendImageMessageUseCase sendImageMessageUseCase;
  final AddImageStatusUseCase addImageStatusUseCase;
  final GetChatMediaUseCase getChatMediaUseCase;
  HomeCubit({
    required this.getChatsUseCase,
    required this.getAllUsersUseCase,
    required this.sendTextMessageUseCase,
    required this.getChatMessagesUseCase,
    required this.addTextStatusUseCase,
    required this.getStatusUseCase,
    required this.sendImageMessageUseCase,
    required this.addImageStatusUseCase,
    required this.getChatMediaUseCase,
  }) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

// Layout
  int currentIndex = 0;
  void changeIndex(index, context) {
    emit(HomeInitial());
    currentIndex = index;
    switch (index) {
      case 0:
        getAllChats();
        break;
      case 1:
        getStatus(context);
        break;
      default:
    }
    emit(ChangeCurrentIndexState());
  }

  List<User> allUsers = [];
  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());
    final response = await getAllUsersUseCase.call(NoParams());
    response.fold(
      (failure) => emit(GetAllUsersErrorState(_mapFailureToMsg(failure))),
      (users) {
        allUsers = users;
        emit(GetAllUsersSuccessState(users));
      },
    );
  }

  User searchUser(uid) {
    late User user;
    for (var element in allUsers) {
      if (element.uId == uid) {
        user = element;
      }
    }
    return user;
  }

// Chats
  final chatController = ScrollController();

  Future<void> sendTextMessage({
    required String message,
    required String time,
    required String date,
    required String dateTime,
    required String receiverId,
  }) async {
    emit(SendTextMessageLoadingState());
    Message msg = Message(
      message: message,
      time: time,
      date: date,
      dateTime: dateTime,
      recieverId: receiverId,
    );
    final response = await sendTextMessageUseCase.call(msg);

    response.fold(
      (failure) => emit(SendTextMessageErrorState(_mapFailureToMsg(failure))),
      (right) {
        chatController.jumpTo(chatController.position.maxScrollExtent);
        emit(SendTextMessageSuccessState());
      },
    );
  }

  File fileImage = File('');
  ImagePicker picker = ImagePicker();
  dynamic pickedFile;

  Future<void> getGalleryImage({
    required context,
    required String recieverId,
  }) async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      fileImage = File(pickedFile.path);
      cropImage(
        context: context,
        recieverId: recieverId,
      );
    }
  }

  Future<void> cropImage({
    required context,
    required String recieverId,
  }) async {
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
          enableResize: true,
          enableZoom: true,
          enableOrientation: true,
        ),
      ],
    );
    if (croppedImage != null) {
      emit(SendImageMessageLoadingState());
      fileImage = File(croppedImage.path);
      ImageMessageParams params = ImageMessageParams(
        image: fileImage,
        recieverId: recieverId,
      );
      final response = await sendImageMessageUseCase(params);
      emit(
        response.fold(
          (failure) => SendImageMessageErrorState(_mapFailureToMsg(failure)),
          (right) => SendImageMessageSuccessState(),
        ),
      );
    }
  }

  Stream<List<Message>>? curruntChatMessages;
  Stream<List<Message>>? getChatMessages({
    required String uId,
    required String name,
    required String image,
  }) {
    emit(GetChatMessagesLoadingState());
    GetMessagesParams params = GetMessagesParams(
      name: name,
      image: image,
      uId: uId,
    );
    curruntChatMessages = getChatMessagesUseCase.call(params);
    if (curruntChatMessages != null) {
      curruntChatMessages!.listen(
        (event) {
          chatController.jumpTo(chatController.position.maxScrollExtent);
        },
      );
    }
    return curruntChatMessages;
  }

  List<Contact> allContacts = [];
  Contact? currentContact;
  Future<void> getAllChats() async {
    emit(GetAllChatsLoadingState());
    final response = await getChatsUseCase.call(NoParams());
    response.fold(
      (failure) => emit(GetAllChatsErrorState(_mapFailureToMsg(failure))),
      (contacts) {
        contacts.sort(
          (a, b) => DateTime.parse(b.dateTime).compareTo(
            DateTime.parse(a.dateTime),
          ),
        );
        allContacts = contacts;
        emit(GetAllChatsSuccessState(contacts));
      },
    );
  }

  List<Message> media = [];
  Future<void> getChatMedia({
    required String recieverId,
  }) async {
    emit(GetChatMediaLoadingState());
    final response = await getChatMediaUseCase.call(recieverId);
    response.fold(
      (failure) => emit(GetChatMediaErrorState(_mapFailureToMsg(failure))),
      (media) {
        this.media = media;
        emit(GetChatMediaSuccessState());
      },
    );
  }

// Status

  List<int> statusColor = <int>[
    0xffD9A537,
    0xffDA6C55,
    0xffB78479,
    0xffC692DD,
    0xffFE7E6B,
    0xff81DF78,
    0xff60CBEA,
  ];

  int currentColor = 0xffD9A537;
  changeStatusColor(int color) {
    emit(HomeInitial());
    currentColor = color;
    emit(ChangeStatusColorState());
  }

  Future<void> addTextStatus({
    required String status,
    required int color,
    required context,
  }) async {
    emit(AddStatusLoadingState());
    final params = AddTextStatusParams(
      status: status,
      color: color,
    );
    final response = await addTextStatusUseCase.call(params);
    emit(
      response.fold(
        (failure) => AddStatusErrorState(_mapFailureToMsg(failure)),
        (right) => AddStatusSuccessState(),
      ),
    );
    getStatus(context);
  }

  Future<void> getStatusImage(context) async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      fileImage = File(pickedFile.path);
      cropStatusImage(context);
    }
  }

  Future<void> cropStatusImage(context) async {
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
      emit(CropStatusImageSuccessState(File(croppedImage.path)));
    } else {
      emit(CropStatusImageErrorState());
    }
  }

  final captionController = TextEditingController();

  Future<void> addImageStatus(
      {required File image, required String caption, required context}) async {
    emit(AddStatusLoadingState());
    final params = ImageStatusParams(
      image: image,
      caption: caption,
    );
    final response = await addImageStatusUseCase.call(params);
    emit(
      response.fold(
        (failure) => AddStatusErrorState(_mapFailureToMsg(failure)),
        (right) => AddStatusSuccessState(),
      ),
    );
    getStatus(context);
  }

  List<Status> myStatus = [];
  Map<String, List<Status>> contactsStatus = {};
  List<String> statusId = [];
  Future<void> getStatus(context) async {
    if (allUsers.isEmpty) {
      await getAllUsers();
    }
    emit(GetAllStatusLoadingState());
    List<String> usersId = [];
    for (var user in allUsers) {
      usersId.add(user.uId);
    }
    final response = await getStatusUseCase.call(usersId);
    response.fold(
      (failure) => null,
      (status) {
        status.forEach(
          (key, value) {
            if (value.isNotEmpty) {
              if (key == AuthenticationCubit.get(context).currentUser!.uId) {
                myStatus = value;
              } else {
                contactsStatus[key] = value;
                statusId.add(key);
                print(contactsStatus);
              }
            }
          },
        );
      },
    );
    emit(GetAllStatusSuccessState());
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
