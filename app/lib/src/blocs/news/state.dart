part of 'bloc.dart';

abstract class NewsState {
  const NewsState();
}

class LoginLoading extends NewsState {
  const LoginLoading();
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

/* class LoginToRegister extends NewsState {
  const LoginToRegister();
}
 */