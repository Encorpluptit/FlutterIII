import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoading());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginLoadEvent || event is LoginRefreshEvent) {
      yield* (await _LoginLoad());
    }
    if (event is LoginClickOnDetails) {
      yield* (await _LoginClickOnDetails(event));
    }
  }

  Stream<LoginState> _LoginLoad() async* {
    try {
      yield LoginLoadedSuccess({} as dynamic);
    } on Exception catch (error) {
      yield LoginLoadedFailure(error.toString());
    }
  }

  Stream<LoginState> _LoginClickOnDetails(LoginClickOnDetails event) async* {
    yield (LoginClickOnDetailsSuccess(event.id));
  }
}
