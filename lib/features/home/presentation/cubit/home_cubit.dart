import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/home/domain/entities/message.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/get_all_users.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/send_text_message.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  HomeCubit({
    required this.getAllUsersUseCase,
    required this.sendTextMessageUseCase,
  }) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

// Layout
  int currentIndex = 0;
  void changeIndex(index) {
    emit(HomeInitial());
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());
    final response = await getAllUsersUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => GetAllUsersErrorState(_mapFailureToMsg(failure)),
        (users) => GetAllUsersSuccessState(users),
      ),
    );
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
    emit(
      response.fold(
        (failure) => SendTextMessageErrorState(_mapFailureToMsg(failure)),
        (right) => SendTextMessageSuccessState(),
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
