import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterOnPage());
}
