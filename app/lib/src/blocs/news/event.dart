part of 'bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

class NewsClickOnNewsEvent extends NewsEvent {
  final String data;

  const NewsClickOnNewsEvent(this.data);
}

/* class LoginToRegisterEvent extends NewsEvent {}

class LoginToRegisterDoneEvent extends NewsEvent {} */
