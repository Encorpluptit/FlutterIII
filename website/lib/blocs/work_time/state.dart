part of 'bloc.dart';

abstract class UserWorkTimeState {
  const UserWorkTimeState();
}

class UserWorkTimeWaitingState extends UserWorkTimeState {}

class UserWorkTimeResetState extends UserWorkTimeState {}

class UserWorkTimesLoadedSuccessState extends UserWorkTimeState {
  final List<WorkTimeModel> workTimes;

  const UserWorkTimesLoadedSuccessState(this.workTimes);
}

class UserWorkTimeLoadErrorState extends UserWorkTimeState {
  final String cause;

  const UserWorkTimeLoadErrorState(this.cause);
}
