import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/login/bloc.dart';
import 'package:website/utils/color_constants.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: ColorConstants.blue,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    Center(
                        child: Text(
                      "Time tracking",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 48.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email_controller,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      autofocus: false,
                      controller: password_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      onFieldSubmitted: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginRequestEvent(email_controller.text,
                                password_controller.text));
                      },
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.blue),
                        onPressed: () => {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginRequestEvent(email_controller.text,
                                  password_controller.text))
                        },
                        child: Text('Log In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
