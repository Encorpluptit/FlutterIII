part of 'bloc.dart';

@immutable
abstract class TimeManagerEvent {
  const TimeManagerEvent();
}

class TimeManagerLoadLoginEvent extends TimeManagerEvent {
  const TimeManagerLoadLoginEvent();
}

class TimeManagerLoadGuestEvent extends TimeManagerEvent {
  const TimeManagerLoadGuestEvent();
}
