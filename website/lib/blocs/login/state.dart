part of 'bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginWaitingState extends LoginState {}

class LoginRequestSuccessState extends LoginState {}

class LoginRequestFailureState extends LoginState {
  final String message;

  LoginRequestFailureState(this.message);
}

class LoginLogoutState extends LoginState {}
