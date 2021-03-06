import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/account/bloc.dart';
import 'package:timetracking/src/blocs/login/bloc.dart';
import 'package:timetracking/src/blocs/register/bloc.dart';
import 'package:timetracking/src/ui/screens/login.dart';
import 'package:timetracking/src/ui/screens/register.dart';
import 'package:timetracking/src/ui/widgets/account_guest.dart';
import 'package:timetracking/src/ui/widgets/account_loading.dart';
import 'package:timetracking/src/ui/widgets/account_logged.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) async {
          if (state is AccountNavigate) {
            BlocProvider.of<AccountBloc>(context)
                .add(const AccountNavigationDoneEvent());
            switch (state.to) {
              case "register":
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => BlocProvider(
                              create: (_) => RegisterBloc(),
                              child: const RegisterScreen(),
                            )));
                break;
              case "login":
                final email = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => BlocProvider(
                              create: (_) => LoginBloc(),
                              child: const LoginScreen(),
                            )));
                if (email is String) {
                  BlocProvider.of<AccountBloc>(context)
                      .add(AccountLoginEvent(email));
                }
                break;
            }
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
            buildWhen: (AccountState previous, AccountState current) {
          return (true);
        }, builder: (context, state) {
          if (state is AccountGuest) {
            return (const AccountGuestPage());
          } else if (state is AccountLoggedIn) {
            return (AccountLoggedInPage(email: state.email));
          } else if (state is AccountLoading) {
            return (const AccountLoadingPage());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
