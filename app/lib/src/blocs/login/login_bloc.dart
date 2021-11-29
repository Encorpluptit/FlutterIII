import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginOnPage());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginLoadEvent) {
      yield* (_loginLoad());
    }
  }

  Stream<LoginState> _loginLoad() async* {
    try {
      yield const LoginLoadedSuccess();
    } on Exception catch (error) {
      yield LoginLoadedFailure(error.toString());
    }
  }
}
