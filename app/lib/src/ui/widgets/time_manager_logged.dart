import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/ui/themes/themes.dart';
import 'package:timetracking/src/ui/widgets/big_button.dart';

class TimeManagerLoggedInPage extends StatefulWidget {
  const TimeManagerLoggedInPage({Key? key}) : super(key: key);

  @override
  _TimeManagerLoggedInPageState createState() =>
      _TimeManagerLoggedInPageState();
}

class _TimeManagerLoggedInPageState extends State<TimeManagerLoggedInPage> {
  late String formattedTime;
  @override
  void initState() {
    formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(formattedTime)],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      formattedTime = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
