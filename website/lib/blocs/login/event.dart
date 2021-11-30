part of 'bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginWaitingEvent extends LoginEvent {}

class LoginRequestEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestEvent(this.email, this.password);
}

class LoginLogoutEvent extends LoginEvent {}
