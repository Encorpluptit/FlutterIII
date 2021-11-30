part of 'bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginWaitingState extends LoginState {
  LoginWaitingState();
}

class LoginRequestSuccessState extends LoginState {}

class LoginRequestFailureState extends LoginState {
  final String message;

  LoginRequestFailureState(this.message);
}
