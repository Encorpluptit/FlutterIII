part of 'bloc.dart';

abstract class WorkTimesManagerState {
  const WorkTimesManagerState();
}

class WorkTimesManagerLoggedIn extends WorkTimesManagerState {
  const WorkTimesManagerLoggedIn();
}

class WorkTimesManagerError extends WorkTimesManagerState {
  final String error;
  const WorkTimesManagerError(this.error);
}

class WorkTimesManagerLoading extends WorkTimesManagerState {
  const WorkTimesManagerLoading();
}

class WorkTimesManagerRequestError extends WorkTimesManagerState {
  final String cause;
  const WorkTimesManagerRequestError(this.cause);
}
