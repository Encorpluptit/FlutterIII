part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginLoadedSuccess extends LoginState {
  final List<dynamic> movies;

  const LoginLoadedSuccess([this.movies = const []]);
}

class LoginLoadedFailure extends LoginState {
  String cause = "";

  LoginLoadedFailure(this.cause);
}

class LoginClickOnDetailsSuccess extends LoginState {
  final String id;

  const LoginClickOnDetailsSuccess(this.id);
}
