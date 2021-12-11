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
  final DateTime time;
  final Position position;
  const TimeManagerClockInEvent(this.time, this.position);
}

class TimeManagerClockOutEvent extends TimeManagerEvent {
  final DateTime time;
  final Position position;
  const TimeManagerClockOutEvent(this.time, this.position);
}

class TimeManagerReloadEvent extends TimeManagerEvent {
  const TimeManagerReloadEvent();
}

class TimeManagerLoadEvent extends TimeManagerEvent {
  const TimeManagerLoadEvent();
}
