part of 'bloc.dart';

@immutable
abstract class UsersEvent {
  const UsersEvent();
}

class UsersWaitingEvent extends UsersEvent {}

class UsersLoadEvent extends UsersEvent {}

class UsersLoadedSuccessEvent extends UsersEvent {}

class UsersClickOnDetailsEvent extends UsersEvent {
  final int selectedUser;

  const UsersClickOnDetailsEvent(this.selectedUser);
}

class UserClickOnWorkTimesEvent extends UsersEvent {
  final User user;
  const UserClickOnWorkTimesEvent(this.user);
}

class UsersUpdateEvent extends UsersEvent {
  final User user;

  const UsersUpdateEvent(this.user);
}
