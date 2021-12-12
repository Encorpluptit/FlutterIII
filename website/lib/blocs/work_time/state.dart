part of 'bloc.dart';

abstract class UserWorkTimeState {
  const UserWorkTimeState();
}

class UserWorkTimeWaitingState extends UserWorkTimeState {}

// class UsersLoadedSuccessState extends UserWorkTimeState {
//   List<User> users;
//   int selectedUser = -1;
//
//   UsersLoadedSuccessState(this.users, {this.selectedUser = -1});
// }

class UserWorkTimesLoadedSuccessState extends UserWorkTimeState {
  final List<WorkTime> workTimes;

  const UserWorkTimesLoadedSuccessState(this.workTimes);
}

class UserWorkTimeLoadErrorState extends UserWorkTimeState {
  final String cause;

  const UserWorkTimeLoadErrorState(this.cause);
}
