part of 'bloc.dart';

@immutable
abstract class TimeManagerEvent {
  const TimeManagerEvent();
}

class TimeManagerLoadLoginEvent extends TimeManagerEvent {
  final String action;
  const TimeManagerLoadLoginEvent(this.action);
}

class TimeManagerLoadErrorEvent extends TimeManagerEvent {
  final String error;
  const TimeManagerLoadErrorEvent(this.error);
}

class TimeManagerClockInEvent extends TimeManagerEvent {
  final String time;
  const TimeManagerClockInEvent(this.time);
}

class TimeManagerClockOutEvent extends TimeManagerEvent {
  final String time;
  const TimeManagerClockOutEvent(this.time);
}
