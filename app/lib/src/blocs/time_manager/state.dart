part of 'bloc.dart';

abstract class TimeManagerState {
  const TimeManagerState();
}

class TimeManagerLoggedIn extends TimeManagerState {
  final String action;
  const TimeManagerLoggedIn(this.action);
}

class TimeManagerGuest extends TimeManagerState {
  const TimeManagerGuest();
}

class TimeManagerLoading extends TimeManagerState {
  const TimeManagerLoading();
}
