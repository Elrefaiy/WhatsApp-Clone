import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/settings/domain/usecases/logout.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LogoutUseCase logoutUseCase;
  SettingsCubit({
    required this.logoutUseCase,
  }) : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeMode() {
    emit(SettingsInitial());
    isDark = !isDark;
    emit(ChangeThemeModeState());
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final response = await logoutUseCase.call(NoParams());
    emit(
      response.fold(
        (failure) => LogoutErrorState(_mapFailureToMsg(failure)),
        (right) => LogoutSuccessState(),
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
