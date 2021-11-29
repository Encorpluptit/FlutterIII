part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginLoadEvent extends LoginEvent {}

class LoginRefreshEvent extends LoginEvent {}

class LoginClickOnDetails extends LoginEvent {
  final String id;

  const LoginClickOnDetails(this.id);
}
