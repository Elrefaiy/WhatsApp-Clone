part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetAllUsersLoadingState extends HomeState {}

class GetAllUsersSuccessState extends HomeState {
  final List<User> users;
  const GetAllUsersSuccessState(this.users);
  @override
  List<Object> get props => [users];
}

class GetAllUsersErrorState extends HomeState {
  final String error;
  const GetAllUsersErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class ChangeCurrentIndexState extends HomeState {}

class SendTextMessageLoadingState extends HomeState {}

class SendTextMessageSuccessState extends HomeState {}

class SendTextMessageErrorState extends HomeState {
  final String error;
  const SendTextMessageErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetChatMessagesLoadingState extends HomeState {}

class GetChatMessagesSuccessState extends HomeState {}

class GetChatMessagesErrorState extends HomeState {
  final String error;
  const GetChatMessagesErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetAllChatsLoadingState extends HomeState {}

class GetAllChatsSuccessState extends HomeState {
  final List<Contact> contacts;
  const GetAllChatsSuccessState(this.contacts);
  @override
  List<Object> get props => [contacts];
}

class GetAllChatsErrorState extends HomeState {
  final String error;
  const GetAllChatsErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class AddStatusLoadingState extends HomeState {}

class AddStatusSuccessState extends HomeState {}

class AddStatusErrorState extends HomeState {
  final String error;
  const AddStatusErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetAllStatusLoadingState extends HomeState {}

class GetAllStatusSuccessState extends HomeState {}

class GetAllStatusErrorState extends HomeState {
  final String error;
  const GetAllStatusErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class ChangeStatusColorState extends HomeState {}

class CropStatusImageSuccessState extends HomeState {
  final File image;
  const CropStatusImageSuccessState(this.image);
  @override
  List<Object> get props => [image];
}

class CropStatusImageErrorState extends HomeState {}

class SendImageMessageLoadingState extends HomeState {}

class SendImageMessageSuccessState extends HomeState {}

class SendImageMessageErrorState extends HomeState {
  final String error;
  const SendImageMessageErrorState(this.error);
  @override
  List<Object> get props => [error];
}
