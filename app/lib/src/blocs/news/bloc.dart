import 'dart:async';

/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
/* import 'package:timetracking/src/utils/shared_preferences.dart';
import 'package:timetracking/src/utils/global.dart' as global; */

part 'event.dart';
part 'state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsOnPage()) {
    on<NewsClickOnNewsEvent>(
        (event, emit) async => emit(await _newsRequest(event)));
    /* on<LoginToRegisterEvent>((event, emit) => emit(const LoginToRegister()));
    on<LoginToRegisterDoneEvent>((event, emit) => emit(const LoginOnPage())); */
  }

  Future<NewsState> _newsRequest(NewsClickOnNewsEvent event) async {
    print("Article");
    /* try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);

      if (userCredential.user != null) {
        final query = FirebaseFirestore.instanceFor(app: global.app)
            .collection("users")
            .doc(userCredential.user!.uid);
        final result = await query.get();
        if (result.data()!["role"] != "Admin") {
          return (LoginLoadedFailure("You're not an administrator"));
        }
      } 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginLoadedFailure("No user found that email");
      } else if (e.code == 'wrong-password') {
        return LoginLoadedFailure("Wrong password provided");
      } else if (e.code == 'invalid-email') {
        return LoginLoadedFailure("Email is not well formatted");
      } else {
        return LoginLoadedFailure("Unknown error: " + e.code.toString());
      }
    } catch (e) {
      return LoginLoadedFailure("You're not an administrator");
    } */

    /* await MySharedPreferences()
        .set("AUTH", FirebaseAuth.instance.currentUser!.uid); */
    return const NewsLoadedSuccess();
  }
}
