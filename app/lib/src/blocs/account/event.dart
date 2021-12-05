part of 'bloc.dart';

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

class AccountNavigateEvent extends AccountEvent {
  final String to;
  const AccountNavigateEvent(this.to);
}

class AccountNavigationDoneEvent extends AccountEvent {
  const AccountNavigationDoneEvent();
}
