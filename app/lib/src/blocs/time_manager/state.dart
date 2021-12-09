part of 'bloc.dart';

abstract class TimeManagerState {
  const TimeManagerState();
}

class TimeManagerLoggedIn extends TimeManagerState {
  const TimeManagerLoggedIn();
}

class TimeManagerGuest extends TimeManagerState {
  const TimeManagerGuest();
}

class TimeManagerLoading extends TimeManagerState {
  const TimeManagerLoading();
}
