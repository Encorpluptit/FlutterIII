import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListLoading());

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is MovieListLoadEvent || event is MovieListRefreshEvent) {
      yield* (await _MovieListLoad());
    }
    if (event is MovieListClickOnDetails) {
      yield* (await _MovieListClickOnDetails(event));
    }
  }

  Stream<MovieListState> _MovieListLoad() async* {
    try {
      yield MovieListLoadedSuccess({} as dynamic);
    } on Exception catch (error) {
      yield MovieListLoadedFailure(error.toString());
    }
  }

  Stream<MovieListState> _MovieListClickOnDetails(
      MovieListClickOnDetails event) async* {
    yield (MovieListClickOnDetailsSuccess(event.id));
  }
}
