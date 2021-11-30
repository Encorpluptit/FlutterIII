import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/login/login_bloc.dart';
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
          print(state);
          if (state is LoginLoadedFailure) {
            const snackBar = SnackBar(
              duration: Duration(minutes: 5),
              content: Text(
                  'Eror while retriving the movies. Please try again later.'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is LoginToRegister) {
            // print("LoginToRegisterOK");
            BlocProvider.of<LoginBloc>(context).add(LoginToRegisterDoneEvent());
            // Navigator.pushReplacement(context,
            //     CupertinoPageRoute(builder: (context) => RegisterScreen()));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (LoginState previous, LoginState current) {
          return (true);
        }, builder: (context, state) {
          if (state is LoginOnPage) {
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
