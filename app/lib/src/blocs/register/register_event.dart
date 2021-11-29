part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterLoadEvent extends RegisterEvent {}

class RegisterRefreshEvent extends RegisterEvent {}

class RegisterClickOnDetails extends RegisterEvent {
  final String id;

  const RegisterClickOnDetails(this.id);
}
