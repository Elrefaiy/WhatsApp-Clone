import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/home/domain/entities/user.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/get_all_users.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  HomeCubit({
    required this.getAllUsersUseCase,
  }) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

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
