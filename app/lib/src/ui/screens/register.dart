import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/register/bloc.dart';
import 'package:timetracking/src/ui/widgets/register_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadedFailure) {
            var snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              content: Text(state.cause),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RegisterLoadedSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (RegisterState previous, RegisterState current) {
          return (true);
        }, builder: (context, state) {
          if (state is RegisterOnPage || state is RegisterLoadedFailure) {
            return (const RegisterPage());
          } else if (state is RegisterLoading) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          } else if (state is RegisterLoadedFailure) {
            return (Container());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
