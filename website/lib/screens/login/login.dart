import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/login/bloc.dart';
import 'package:website/screens/home/home_screen.dart';
import 'package:website/utils/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:website/utils/shared_preferences.dart';
import 'package:website/utils/global.dart' as global;
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (LoginState previous, LoginState current) {
          if (current is LoginRequestFailureState) {
            return (false);
          }
          return (true);
        }, builder: (context, state) {
          if (state is LoginWaitingState) {
            return (LoginForm());
          }
          return (Container());
        }),
      ),
    );
  }
}
