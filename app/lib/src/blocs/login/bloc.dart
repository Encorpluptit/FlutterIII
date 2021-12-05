import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:timetracking/src//utils/global.dart' as global;
import 'package:timetracking/src/utils/shared_preferences.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginOnPage()) {
    on<LoginClickOnLoginEvent>(
        (event, emit) async => emit(await _loginRequest(event)));
    on<LoginToRegisterEvent>((event, emit) => emit(const LoginToRegister()));
    on<LoginToRegisterDoneEvent>((event, emit) => emit(const LoginOnPage()));
  }

  Future<LoginState> _loginRequest(LoginClickOnLoginEvent event) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      await MySharedPreferences()
          .set("AUTH", FirebaseAuth.instance.currentUser!.uid);
      return LoginLoadedSuccess(FirebaseAuth.instance.currentUser!.email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return LoginLoadedFailure("No user found for this email");
        case "wrong-password":
          return LoginLoadedFailure("Wrong password provided");
        case 'invalid-email':
          return LoginLoadedFailure("Email is not well formatted");
        default:
          return LoginLoadedFailure("Unknown error: " + e.code.toString());
      }
    } catch (e) {
      return LoginLoadedFailure("You're not an administrator");
    }
  }
}
