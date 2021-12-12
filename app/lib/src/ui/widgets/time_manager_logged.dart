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
  late DateTime currentTime;
  @override
  void initState() {
    currentTime = DateTime.now();
    _getTime();
    if (mounted) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
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
                              currentTime,
                              await Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.best,
                              ),
                            ));
                          } else {
                            BlocProvider.of<TimeManagerBloc>(context)
                                .add(TimeManagerClockOutEvent(
                              currentTime,
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
    currentTime = DateTime.now();
    final String formattedDateTime = _formatDateTime(currentTime);
    if (mounted) {
      setState(() {
        formattedTime = formattedDateTime;
      });
    }
  }
}
