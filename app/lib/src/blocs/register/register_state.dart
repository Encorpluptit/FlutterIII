part of 'register_bloc.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterLoading extends RegisterState {
  RegisterLoading();
}

class RegisterLoadedSuccess extends RegisterState {
  final List<dynamic> movies;

  const RegisterLoadedSuccess([this.movies = const []]);
}

class RegisterLoadedFailure extends RegisterState {
  String cause = "";

  RegisterLoadedFailure(this.cause);
}

class RegisterClickOnDetailsSuccess extends RegisterState {
  final String id;

  const RegisterClickOnDetailsSuccess(this.id);
}
