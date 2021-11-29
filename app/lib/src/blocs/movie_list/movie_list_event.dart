part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent {
  const MovieListEvent();
}

class MovieListLoadEvent extends MovieListEvent {}

class MovieListRefreshEvent extends MovieListEvent {}

class MovieListClickOnDetails extends MovieListEvent {
  final String id;

  const MovieListClickOnDetails(this.id);
}
