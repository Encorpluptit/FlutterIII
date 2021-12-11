part of 'bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

/* class NewsLoadLoginEvent extends NewsEvent {
  const NewsLoadLoginEvent();
} */

class NewsLoadErrorEvent extends NewsEvent {
  final String error;
  const NewsLoadErrorEvent(this.error);
}

class NewsLoadEvent extends NewsEvent {
  const NewsLoadEvent();
}
