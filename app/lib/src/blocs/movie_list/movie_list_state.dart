part of 'movie_list_bloc.dart';

abstract class MovieListState {
  const MovieListState();
}

class MovieListLoading extends MovieListState {
  MovieListLoading();
}

class MovieListLoadedSuccess extends MovieListState {
  final List<dynamic> movies;

  const MovieListLoadedSuccess([this.movies = const []]);
}

class MovieListLoadedFailure extends MovieListState {
  String cause = "";

  MovieListLoadedFailure(this.cause);
}

class MovieListClickOnDetailsSuccess extends MovieListState {
  final String id;

  const MovieListClickOnDetailsSuccess(this.id);
}
