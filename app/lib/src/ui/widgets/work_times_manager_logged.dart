import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/blocs/work_times_manager/bloc.dart';
import 'package:timetracking/src/ui/widgets/modulable_button.dart';
import 'package:geolocator/geolocator.dart';

class WorkTimesManagerLoggedInPage extends StatefulWidget {
  const WorkTimesManagerLoggedInPage({Key? key}) : super(key: key);

  @override
  _WorkTimesManagerLoggedInPageState createState() =>
      _WorkTimesManagerLoggedInPageState();
}

class _WorkTimesManagerLoggedInPageState
    extends State<WorkTimesManagerLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: SingleChildScrollView(),
    );
  }
}
