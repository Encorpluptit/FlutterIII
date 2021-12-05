import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterOnPage()) {
    on<RegisterClickOnRegisterEvent>(
        (event, emit) async => emit(await _registerRequest(event)));
  }

  Future<RegisterState> _registerRequest(
      RegisterClickOnRegisterEvent event) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      return const RegisterLoadedSuccess();
    } on FirebaseAuthException catch (e) {
      return RegisterLoadedFailure("Unknown error: ${e.message}");
    } catch (e) {
      return RegisterLoadedFailure(e.toString());
    }
  }
}
