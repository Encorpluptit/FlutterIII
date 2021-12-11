import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/ui/widgets/time_manager_error.dart';
import 'package:timetracking/src/ui/widgets/time_manager_loading.dart';
import 'package:timetracking/src/ui/widgets/time_manager_logged.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';

class TimeManagerScreen extends StatefulWidget {
  const TimeManagerScreen({Key? key}) : super(key: key);

  @override
  _TimeManagerScreenState createState() => _TimeManagerScreenState();
}

class _TimeManagerScreenState extends State<TimeManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<TimeManagerBloc, TimeManagerState>(
        listener: (context, state) async {
          if (state is TimeManagerError) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              content: Text('Error ${state.error}'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<TimeManagerBloc, TimeManagerState>(
            buildWhen: (TimeManagerState previous, TimeManagerState current) {
          return (true);
        }, builder: (context, state) {
          if (state is TimeManagerError) {
            return (RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<TimeManagerBloc>(context)
                      .add(const TimeManagerReloadEvent());
                },
                child: TimeManagerErrorPage(
                  error: state.error,
                )));
          } else if (state is TimeManagerLoggedIn) {
            return (RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<TimeManagerBloc>(context)
                      .add(const TimeManagerReloadEvent());
                },
                child: TimeManagerLoggedInPage(
                  action: state.action,
                )));
          } else if (state is TimeManagerLoading) {
            return (const TimeManagerLoadingPage());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
