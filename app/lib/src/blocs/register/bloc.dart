import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterOnPage()) {
    on<RegisterClickOnRegisterEvent>(
        (event, emit) => emit(const RegisterLoading()));
    on<RegisterToLoginEvent>((event, emit) => emit(const RegisterToLogin()));
    on<RegisterToLoginDoneEvent>((event, emit) => emit(const RegisterOnPage()));
  }
}
