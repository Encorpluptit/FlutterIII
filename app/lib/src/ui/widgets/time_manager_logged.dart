import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/ui/widgets/modulable_button.dart';
import 'package:geolocator/geolocator.dart';

class TimeManagerLoggedInPage extends StatefulWidget {
  final String action;
  const TimeManagerLoggedInPage({Key? key, required this.action})
      : super(key: key);

  @override
  _TimeManagerLoggedInPageState createState() =>
      _TimeManagerLoggedInPageState();
}

class _TimeManagerLoggedInPageState extends State<TimeManagerLoggedInPage> {
  late String formattedTime;
  @override
  void initState() {
    formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    if (mounted) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    }
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
                children: <Widget>[
                  Text(formattedTime),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (widget.action == "Clock In") {
                        BlocProvider.of<TimeManagerBloc>(context)
                            .add(TimeManagerClockInEvent(
                          formattedTime,
                          await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.best,
                          ),
                        ));
                      } else {
                        BlocProvider.of<TimeManagerBloc>(context)
                            .add(TimeManagerClockOutEvent(
                          formattedTime,
                          await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.best,
                          ),
                        ));
                      }
                    },
                    child: ModulableButton(
                      textValue: widget.action,
                      width: 75,
                      height: 75,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        formattedTime = formattedDateTime;
      });
    }
  }
}
