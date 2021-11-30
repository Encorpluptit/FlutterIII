part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginClickOnLoginEvent extends LoginEvent {}

class LoginToRegisterEvent extends LoginEvent {}

class LoginToRegisterDoneEvent extends LoginEvent {}
