import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/work_times_manager/bloc.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timetracking/src/utils/global.dart' as global;

class WorkTimesManagerLoadingPage extends StatefulWidget {
  const WorkTimesManagerLoadingPage({Key? key}) : super(key: key);

  @override
  _WorkTimesManagerLoadingPageState createState() =>
      _WorkTimesManagerLoadingPageState();
}

class _WorkTimesManagerLoadingPageState
    extends State<WorkTimesManagerLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("USER_EMAIL").then((email) {
      if (email != null && email.isNotEmpty) {
        BlocProvider.of<WorkTimesManagerBloc>(context)
            .add(const WorkTimesManagerLoadLoginEvent());
      } else {
        BlocProvider.of<WorkTimesManagerBloc>(context)
            .add(const WorkTimesManagerLoadErrorEvent("Please login first"));
      }
    });
    return Center(
      child: Column(
        children: const [CircularProgressIndicator(), Text("Loading")],
      ),
    );
  }
}
