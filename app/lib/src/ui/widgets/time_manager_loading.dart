import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';

class TimeManagerLoadingPage extends StatefulWidget {
  const TimeManagerLoadingPage({Key? key}) : super(key: key);

  @override
  _TimeManagerLoadingPageState createState() => _TimeManagerLoadingPageState();
}

class _TimeManagerLoadingPageState extends State<TimeManagerLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("email").then((email) {
      if (email != null && email.isNotEmpty) {
        BlocProvider.of<TimeManagerBloc>(context)
            .add(const TimeManagerLoadLoginEvent());
      } else {
        BlocProvider.of<TimeManagerBloc>(context)
            .add(const TimeManagerLoadGuestEvent());
      }
    });
    return Center(
      child: Column(
        children: const [CircularProgressIndicator(), Text("Loading")],
      ),
    );
  }
}
