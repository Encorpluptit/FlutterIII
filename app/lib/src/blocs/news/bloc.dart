import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsOnPage()) {
    on<NewsClickOnNewsEvent>(
        (event, emit) async => emit(await _newsRequest(event)));
  }

  Future<NewsState> _newsRequest(NewsClickOnNewsEvent event) async {
    return const NewsLoadedSuccess();
  }
}
