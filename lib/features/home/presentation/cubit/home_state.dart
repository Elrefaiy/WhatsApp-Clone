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

class GetChatMessagesSuccessState extends HomeState {
  final Stream<List<Message>> messages;
  const GetChatMessagesSuccessState(this.messages);
  @override
  List<Object> get props => [messages];
}

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

class AddTextStatusLoadingState extends HomeState {}

class AddTextStatusSuccessState extends HomeState {}

class AddTextStatusErrorState extends HomeState {
  final String error;
  const AddTextStatusErrorState(this.error);
  @override
  List<Object> get props => [error];
}
