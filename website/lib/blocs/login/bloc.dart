import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:website/utils/global.dart' as global;
import 'package:website/utils/shared_preferences.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginWaitingState()) {
    on<LoginWaitingEvent>((event, emit) => emit(LoginWaitingState()));
    on<LoginRequestEvent>(
        (event, emit) async => emit(await _LoginRequest(event)));
    on<LoginLogoutEvent>((event, emit) async => emit(await _Logout()));
  }

  Future<LoginState> _LoginRequest(LoginRequestEvent event) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);

      if (userCredential.user != null) {
        final query = FirebaseFirestore.instanceFor(app: global.app)
            .collection("users")
            .doc(userCredential.user!.uid);
        final result = await query.get();
        if (result.data()!["role"] != "Admin") {
          return (LoginRequestFailureState("You're not an administrator"));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginRequestFailureState("No user found that email");
      } else if (e.code == 'wrong-password') {
        return LoginRequestFailureState("Wrong password provided");
      } else if (e.code == 'invalid-email') {
        return LoginRequestFailureState("Email is not well formatted");
      } else {
        return LoginRequestFailureState("Unknown error: " + e.code.toString());
      }
    } catch (e) {
      return LoginRequestFailureState("You're not an administrator");
    }

    await MySharedPreferences()
        .set("AUTH", FirebaseAuth.instance.currentUser!.uid);
    return LoginRequestSuccessState();
  }

  Future<LoginState> _Logout() async {
    await FirebaseAuth.instance.signOut();
    await MySharedPreferences().unset("AUTH");

    return (LoginLogoutState());
  }
}
