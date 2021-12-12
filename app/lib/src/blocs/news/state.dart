part of 'bloc.dart';

abstract class NewsState {
  const NewsState();
}

class NewsLoggedIn extends NewsState {
  final List<NewsData> newsData;
  const NewsLoggedIn(this.newsData);
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoadedFailure extends NewsState {
  String error = "";

  NewsLoadedFailure(this.error);
}
