import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class TimeManagerBloc extends Bloc<TimeManagerEvent, TimeManagerState> {
  final TimeManagerState initialState;
  TimeManagerBloc([this.initialState = const TimeManagerLoading()])
      : super(initialState) {
    on<TimeManagerLoadGuestEvent>(
        (event, emit) => emit(const TimeManagerGuest()));
    on<TimeManagerLoadLoginEvent>(
        (event, emit) => emit(const TimeManagerLoggedIn()));
  }
}
