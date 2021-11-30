part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoadedSuccess extends LoginState {
  const LoginLoadedSuccess();
}

class LoginLoadedFailure extends LoginState {
  String cause = "";

  LoginLoadedFailure(this.cause);
}

class LoginOnPage extends LoginState {
  const LoginOnPage();
}

class LoginToRegister extends LoginState {
  const LoginToRegister();
}
