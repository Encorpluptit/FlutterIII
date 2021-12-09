import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetracking/src/utils/global.dart' as global;
part 'event.dart';
part 'state.dart';

class TimeManagerBloc extends Bloc<TimeManagerEvent, TimeManagerState> {
  final TimeManagerState initialState;
  TimeManagerBloc([this.initialState = const TimeManagerLoading()])
      : super(initialState) {
    on<TimeManagerLoadErrorEvent>(
        (event, emit) => emit(TimeManagerError(event.error)));
    on<TimeManagerLoadLoginEvent>((event, emit) async {
      if (event.action == "Clock In") {
        MySharedPreferences().set("CLOCK_STATE", "IN");
      } else {
        MySharedPreferences().set("CLOCK_STATE", "OUT");
      }
      emit(TimeManagerLoggedIn(event.action));
    });
    on<TimeManagerClockInEvent>(
        (event, emit) async => emit(await _clockInRequest(event)));
    on<TimeManagerClockOutEvent>(
        (event, emit) async => emit(await _clockOutRequest(event)));
  }

  Future<TimeManagerState> _clockInRequest(
      TimeManagerClockInEvent event) async {
    try {
      CollectionReference inOut = global.store.collection('in_out');
      inOut.add(
        {
          "user": "/users/${await MySharedPreferences().get('AUTH')}",
          "created_at": DateTime.now(),
          "updated_at": null,
          "in": event.time,
          "out": null,
          "in_longitude": event.position.longitude,
          "in_latitude": event.position.latitude,
          "out_longitude": null,
          "out_latitude": null,
        },
      ).catchError((onError) {
        throw FirebaseException(
          plugin: onError.toString(),
          message: onError.toString(),
        );
      });
      MySharedPreferences().set("CLOCK_STATE", "OUT");
      return const TimeManagerLoggedIn("Clock Out");
    } on FirebaseException catch (error) {
      return TimeManagerError(error.message!);
    } on Exception catch (error) {
      return TimeManagerError(error.toString());
    }
  }

  Future<TimeManagerState> _clockOutRequest(
      TimeManagerClockOutEvent event) async {
    try {
      final String userId = await MySharedPreferences().get("AUTH");
      global.store
          .collection("in_out")
          .orderBy("created_at", descending: true)
          .where("user", isEqualTo: "/users/$userId")
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          var firstElem = value.docs.first;
          global.store.doc("/in_out/${firstElem.id}").update({
            "out": event.time,
            "out_longitude": event.position.longitude,
            "out_latitude": event.position.latitude,
          }).catchError((onError) {
            throw FirebaseException(
              plugin: onError.toString(),
              message: onError.toString(),
            );
          });
        }
      });
      MySharedPreferences().set("CLOCK_STATE", "IN");
      return const TimeManagerLoggedIn("Clock In");
    } on FirebaseException catch (error) {
      return TimeManagerError(error.message!);
    } on Exception catch (error) {
      return TimeManagerError(error.toString());
    }
  }
}
