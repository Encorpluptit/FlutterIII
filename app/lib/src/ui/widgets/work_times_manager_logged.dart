// import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracking/src/models/work_time.dart';
import 'package:timetracking/src/ui/widgets/work_time_card.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:timetracking/src/blocs/work_times_manager/bloc.dart';
// import 'package:timetracking/src/ui/widgets/modulable_button.dart';
// import 'package:geolocator/geolocator.dart';

class WorkTimesManagerLoggedInPage extends StatefulWidget {
  final List<WorkTime> workTimes;
  const WorkTimesManagerLoggedInPage({Key? key, required this.workTimes})
      : super(key: key);

  @override
  _WorkTimesManagerLoggedInPageState createState() =>
      _WorkTimesManagerLoggedInPageState();
}

class _WorkTimesManagerLoggedInPageState
    extends State<WorkTimesManagerLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.workTimes.isEmpty) {
      return (const Scaffold(
          body: Center(
        child: Text(
          "You have never clocked⏱",
          style: TextStyle(fontSize: 20),
        ),
      )));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: widget.workTimes.map<Widget>((workTime) {
              return WorkTimeCard(workTime: workTime);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
