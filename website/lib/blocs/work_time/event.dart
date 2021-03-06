part of 'bloc.dart';

@immutable
abstract class UserWorkTimeEvent {
  const UserWorkTimeEvent();
}

class UserWorkTimeResetEvent extends UserWorkTimeEvent {}

class UserClickOnWorkTimesEvent extends UserWorkTimeEvent {
  final User user;
  const UserClickOnWorkTimesEvent(this.user);
}

class UserWorkTimeUpdateEvent extends UserWorkTimeEvent {
  final WorkTimeModel workTime;
  const UserWorkTimeUpdateEvent(this.workTime);
}
