import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/login/bloc.dart';
import 'package:timetracking/src/ui/routes/main_routes.dart';
import 'package:timetracking/src/ui/screens/login.dart';

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
        create: (_) => LoginBloc(),
        child: const LoginScreen(),
      ),
    );
  }
}
