import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:timetracking/src/models/news.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetracking/src/utils/global.dart' as global;
part 'event.dart';
part 'state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsState initialState;
  NewsBloc([this.initialState = const NewsLoading()]) : super(initialState) {
    on<NewsLoadErrorEvent>(
        (event, emit) => emit(NewsLoadedFailure(event.error)));
    on<NewsLoadEvent>((event, emit) async => emit(await _newsRequest(event)));
  }

  Future<NewsState> _newsRequest(NewsEvent event) async {
    try {
      List<NewsData> newsData = [];
      var resp = await global.store
          .collection("news")
          .orderBy("created_at", descending: true)
          .get();
      if (resp.docs.isNotEmpty) {
        for (var element in resp.docs) {
          newsData.add(NewsData(element.data(), element.id));
        }
      }
      return NewsLoggedIn(newsData);
    } on FirebaseException catch (error) {
      return NewsLoadedFailure(error.message!);
    } on Exception catch (error) {
      return NewsLoadedFailure(error.toString());
    }
  }
}
