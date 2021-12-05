part of 'bloc.dart';

abstract class AccountState {
  const AccountState();
}

class AccountLoggedIn extends AccountState {
  final String email;
  const AccountLoggedIn(this.email);
}

class AccountGuest extends AccountState {
  const AccountGuest();
}

class LoginOnPage extends AccountState {
  const LoginOnPage();
}

class AccountNavigate extends AccountState {
  final String to;
  const AccountNavigate(this.to);
}
