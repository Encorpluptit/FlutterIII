part of 'bloc.dart';

abstract class NewsState {
  const NewsState();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoadedSuccess extends NewsState {
  const NewsLoadedSuccess();
}

class NewsLoadedFailure extends NewsState {
  String cause = "";

  NewsLoadedFailure(this.cause);
}

class NewsOnPage extends NewsState {
  const NewsOnPage();
}