import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:website/models/work_time.dart';
import 'package:website/screens/users/users.dart';
import 'package:website/utils/global.dart' as global;
import 'package:website/widgets/work_time/work_time.dart';

part 'event.dart';
part 'state.dart';

class UserWorkTimeBloc extends Bloc<UserWorkTimeEvent, UserWorkTimeState> {
  UserWorkTimeBloc() : super(UserWorkTimeWaitingState()) {
    on<UserWorkTimeResetEvent>(
        (event, emit) async => emit(_userWorkTimesReset()));
    on<UserClickOnWorkTimesEvent>(
        (event, emit) async => emit(await _userWorkTimes(event.user)));
    on<UserWorkTimeUpdateEvent>(
        (event, emit) async => emit(await _workTimeUpdate(event.workTime)));
  }

  UserWorkTimeState _userWorkTimesReset() {
    return UserWorkTimeResetState();
  }

  Future<UserWorkTimeState> _userWorkTimes(User user) async {
    try {
      List<WorkTimeModel> workTimes = [];
      final resp = await FirebaseFirestore.instanceFor(app: global.app)
          .collection("in_out")
          .orderBy("created_at", descending: true)
          .where("user", isEqualTo: "/users/${user.uuid}")
          .get();
      if (resp.docs.isNotEmpty) {
        for (var element in resp.docs) {
          workTimes.add(WorkTimeModel(element.data(), element.id));
        }
      }
      return UserWorkTimesLoadedSuccessState(workTimes);
    } on FirebaseException catch (error) {
      return UserWorkTimeLoadErrorState(error.message!);
    } on Exception catch (error) {
      return UserWorkTimeLoadErrorState(error.toString());
    }
  }

  Future<UserWorkTimeState> _workTimeUpdate(WorkTime workTime) async {
    try {
      // List<WorkTimeModel> workTimes = [];
      // final resp = await FirebaseFirestore.instanceFor(app: global.app)
      //     .collection("in_out")
      //     .orderBy("created_at", descending: true)
      //     .where("user", isEqualTo: "/users/${user.uuid}")
      //     .get();
      // if (resp.docs.isNotEmpty) {
      //   for (var element in resp.docs) {
      //     workTimes.add(WorkTimeModel(element.data(), element.id));
      //   }
      // }
      // return UserWorkTimeUpdateSuccessState(WorkTimeModel());
      return UserWorkTimeWaitingState();
    } on FirebaseException catch (error) {
      return UserWorkTimeLoadErrorState(error.message!);
    } on Exception catch (error) {
      return UserWorkTimeLoadErrorState(error.toString());
    }
  }
}
