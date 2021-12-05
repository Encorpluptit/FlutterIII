part of 'bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterClickOnRegisterEvent extends RegisterEvent {}

class RegisterToLoginEvent extends RegisterEvent {}

class RegisterToLoginDoneEvent extends RegisterEvent {}
