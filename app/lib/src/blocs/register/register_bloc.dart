import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterLoading());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterLoadEvent || event is RegisterRefreshEvent) {
      yield* (await _RegisterLoad());
    }
    if (event is RegisterClickOnDetails) {
      yield* (await _RegisterClickOnDetails(event));
    }
  }

  Stream<RegisterState> _RegisterLoad() async* {
    try {
      yield RegisterLoadedSuccess({} as dynamic);
    } on Exception catch (error) {
      yield RegisterLoadedFailure(error.toString());
    }
  }

  Stream<RegisterState> _RegisterClickOnDetails(
      RegisterClickOnDetails event) async* {
    yield (RegisterClickOnDetailsSuccess(event.id));
  }
}
