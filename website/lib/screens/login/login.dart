import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/login/bloc.dart';
import 'package:website/screens/layout.dart';
import 'package:website/widgets/login/form.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginRequestFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.message)));
          }
          if (state is LoginRequestSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          }
          if (state is LoginLogoutState) {
            BlocProvider.of<LoginBloc>(context).add(LoginWaitingEvent());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (LoginState previous, LoginState current) {
          if (current is LoginRequestFailureState ||
              current is LoginWaitingState ||
              current is LoginLogoutState) {
            return (false);
          }
          return (true);
        }, builder: (context, state) {
          if (state is LoginWaitingState || state is LoginLogoutState) {
            return (LoginForm());
          }
          return (Container());
        }),
      ),
    );
  }
}
