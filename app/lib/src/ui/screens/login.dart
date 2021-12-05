import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/account/bloc.dart';
import 'package:timetracking/src/blocs/login/bloc.dart';
import 'package:timetracking/src/blocs/register/bloc.dart';
import 'package:timetracking/src/ui/screens/account.dart';
import 'package:timetracking/src/ui/screens/register.dart';
import 'package:timetracking/src/ui/widgets/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedFailure) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              content: Text('Error ${state.cause}'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is LoginLoadedSuccess) {
            Navigator.pop(context, state.email);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (LoginState previous, LoginState current) {
          return (true);
        }, builder: (context, state) {
          if (state is LoginOnPage || state is LoginLoadedFailure) {
            return (const LoginPage());
          } else if (state is LoginLoading) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          } else if (state is LoginLoadedFailure) {
            return (Container());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
