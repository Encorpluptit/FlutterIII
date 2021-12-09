import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
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
    print(event.position.latitude);
    print(event.position.longitude);
    MySharedPreferences().set("CLOCK_STATE", "OUT");
    return const TimeManagerLoggedIn("Clock Out");
  }

  Future<TimeManagerState> _clockOutRequest(
      TimeManagerClockOutEvent event) async {
    print(event.position.latitude);
    print(event.position.longitude);
    MySharedPreferences().set("CLOCK_STATE", "IN");
    return const TimeManagerLoggedIn("Clock In");
  }
}
