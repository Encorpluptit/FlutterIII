import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/ui/widgets/time_manager_guest.dart';
import 'package:timetracking/src/ui/widgets/time_manager_loading.dart';
import 'package:timetracking/src/ui/widgets/time_manager_logged.dart';

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
        listener: (context, state) async {},
        child: BlocBuilder<TimeManagerBloc, TimeManagerState>(
            buildWhen: (TimeManagerState previous, TimeManagerState current) {
          return (true);
        }, builder: (context, state) {
          if (state is TimeManagerGuest) {
            return (const TimeManagerGuestPage());
          } else if (state is TimeManagerLoggedIn) {
            return (const TimeManagerLoggedInPage(
              action: "Clock In",
            ));
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
