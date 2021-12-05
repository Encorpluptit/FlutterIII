import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event.dart';
part 'state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountState initialState;
  AccountBloc([this.initialState = const AccountGuest()])
      : super(initialState) {
    on<AccountNavigateEvent>((event, emit) => emit(AccountNavigate(event.to)));
    on<AccountNavigationDoneEvent>((event, emit) => emit(const AccountGuest()));
  }
}
