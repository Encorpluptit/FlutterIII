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

class WorkTimesManagerDeleteEvent extends WorkTimesManagerEvent {
  final String id;
  const WorkTimesManagerDeleteEvent(this.id);
}

class WorkTimesManagerUpdateEvent extends WorkTimesManagerEvent {
  final String id;
  final DateTime _in;
  final DateTime? out;
  const WorkTimesManagerUpdateEvent(this.id, this._in, this.out);
}

class WorkTimesManagerReloadEvent extends WorkTimesManagerEvent {
  const WorkTimesManagerReloadEvent();
}
