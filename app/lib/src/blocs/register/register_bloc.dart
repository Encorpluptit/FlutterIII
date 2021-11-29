import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterLoading());

  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterLoadEvent) {
      yield* (_registerLoad());
    }
  }

  Stream<RegisterState> _registerLoad() async* {
    try {
      yield const RegisterLoadedSuccess();
    } on Exception catch (error) {
      yield RegisterLoadedFailure(error.toString());
    }
  }
}
