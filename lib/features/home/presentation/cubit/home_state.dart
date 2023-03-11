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
