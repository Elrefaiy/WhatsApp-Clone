import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/chats/get_all_users.dart';
import '../../domain/usecases/chats/get_chat_messages.dart';
import '../../domain/usecases/chats/get_chats.dart';
import '../../domain/usecases/chats/send_text_message.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetChatsUseCase getChatsUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  HomeCubit({
    required this.getChatsUseCase,
    required this.getAllUsersUseCase,
    required this.sendTextMessageUseCase,
    required this.getChatMessagesUseCase,
  }) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

// Layout
  int currentIndex = 0;
  void changeIndex(index) {
    emit(HomeInitial());
    currentIndex = index;
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
        emit(SendTextMessageSuccessState());
      },
    );
  }

  late Stream<List<Message>> curruntChatMessages;
  Stream<List<Message>> getChatMessages({
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
    return curruntChatMessages;
  }

  List<Contact> allContacts = [];
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
