import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/models/work_time.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetracking/src/utils/global.dart' as global;
part 'event.dart';
part 'state.dart';

class WorkTimesManagerBloc
    extends Bloc<WorkTimesManagerEvent, WorkTimesManagerState> {
  final WorkTimesManagerState initialState;
  WorkTimesManagerBloc([this.initialState = const WorkTimesManagerLoading()])
      : super(initialState) {
    on<WorkTimesManagerLoadErrorEvent>(
        (event, emit) => emit(WorkTimesManagerError(event.error)));
    on<WorkTimesManagerLoadLoginEvent>(
        (event, emit) async => emit(await _workTimesManagerRequest(event)));
    on<WorkTimesManagerDeleteEvent>((event, emit) async =>
        emit(await _workTimesManagerDeleteRequest(event)));
    on<WorkTimesManagerReloadEvent>(
        (event, emit) async => emit(const WorkTimesManagerLoading()));
  }

  Future<WorkTimesManagerState> _workTimesManagerRequest(
      WorkTimesManagerEvent event) async {
    try {
      final String userId = await MySharedPreferences().get("AUTH");
      List<WorkTime> workTimes = [];
      var resp = await global.store
          .collection("in_out")
          .orderBy("created_at", descending: true)
          .where("user", isEqualTo: "/users/$userId")
          .get();
      if (resp.docs.isNotEmpty) {
        for (var element in resp.docs) {
          workTimes.add(WorkTime(element.data(), element.id));
        }
      }
      return WorkTimesManagerLoggedIn(workTimes);
    } on FirebaseException catch (error) {
      return WorkTimesManagerError(error.message!);
    } on Exception catch (error) {
      return WorkTimesManagerError(error.toString());
    }
  }

  Future<WorkTimesManagerState> _workTimesManagerDeleteRequest(
      WorkTimesManagerDeleteEvent event) async {
    try {
      global.store.collection("in_out").doc(event.id).delete();
      return const WorkTimesManagerLoading();
    } on FirebaseException catch (error) {
      return WorkTimesManagerError(error.message!);
    } on Exception catch (error) {
      return WorkTimesManagerError(error.toString());
    }
  }
}
