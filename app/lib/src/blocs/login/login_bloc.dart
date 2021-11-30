import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginOnPage()) {
    on<LoginClickOnLoginEvent>((event, emit) => emit(const LoginLoading()));
    on<LoginToRegisterEvent>((event, emit) => emit(const LoginToRegister()));
    on<LoginToRegisterDoneEvent>((event, emit) => emit(const LoginOnPage()));
  }
}
