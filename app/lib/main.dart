import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/login/login_bloc.dart';
import 'package:timetracking/src/blocs/register/register_bloc.dart';
import 'package:timetracking/src/ui/routes/main_routes.dart';
import 'package:timetracking/src/ui/screens/login.dart';
import 'package:timetracking/src/ui/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'timetracking',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (_) => RegisterBloc(),
        child: const RegisterPage(),
      ),
    );
  }
}
