part of 'bloc.dart';

abstract class TimeManagerState {
  const TimeManagerState();
}

class TimeManagerLoggedIn extends TimeManagerState {
  final String action;
  const TimeManagerLoggedIn(this.action);
}

class TimeManagerError extends TimeManagerState {
  final String error;
  const TimeManagerError(this.error);
}

class TimeManagerLoading extends TimeManagerState {
  const TimeManagerLoading();
}

class TimeManagerRequestError extends TimeManagerState {
  final String cause;
  const TimeManagerRequestError(this.cause);
}
