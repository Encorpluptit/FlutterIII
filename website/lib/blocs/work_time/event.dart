part of 'bloc.dart';

@immutable
abstract class UserWorkTimeEvent {
  const UserWorkTimeEvent();
}

class UserClickOnWorkTimesEvent extends UserWorkTimeEvent {
  final User user;
  const UserClickOnWorkTimesEvent(this.user);
}
