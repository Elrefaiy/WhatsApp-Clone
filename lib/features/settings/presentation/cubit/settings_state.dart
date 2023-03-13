part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class ChangeThemeModeState extends SettingsState {}

class LogoutLoadingState extends SettingsState {}

class LogoutSuccessState extends SettingsState {}

class LogoutErrorState extends SettingsState {
  final String message;
  const LogoutErrorState(this.message);
  @override
  List<Object> get props => [message];
}
