part of 'bloc.dart';

@immutable
abstract class WorkTimesManagerEvent {
  const WorkTimesManagerEvent();
}

class WorkTimesManagerLoadLoginEvent extends WorkTimesManagerEvent {
  const WorkTimesManagerLoadLoginEvent();
}

class WorkTimesManagerLoadErrorEvent extends WorkTimesManagerEvent {
  final String error;
  const WorkTimesManagerLoadErrorEvent(this.error);
}

class WorkTimesManagerReloadEvent extends WorkTimesManagerEvent {
  const WorkTimesManagerReloadEvent();
}
