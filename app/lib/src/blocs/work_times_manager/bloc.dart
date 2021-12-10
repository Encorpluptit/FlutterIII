import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:timetracking/src/utils/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:timetracking/src/utils/global.dart' as global;
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
        (event, emit) => emit(const WorkTimesManagerLoggedIn()));
  }
}
