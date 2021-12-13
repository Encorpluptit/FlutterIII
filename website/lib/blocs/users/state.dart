part of 'bloc.dart';

abstract class UsersState {
  const UsersState();
}

class UsersWaitingState extends UsersState {}

class UsersLoadedSuccessState extends UsersState {
  List<User> users;
  int selectedUser = -1;

  UsersLoadedSuccessState(this.users, {this.selectedUser = -1});
}

class UserLoadErrorState extends UsersState {
  final String cause;

  const UserLoadErrorState(this.cause);
}
