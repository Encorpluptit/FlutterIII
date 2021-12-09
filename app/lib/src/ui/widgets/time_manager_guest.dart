import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeManagerGuestPage extends StatefulWidget {
  const TimeManagerGuestPage({Key? key}) : super(key: key);

  @override
  _TimeManagerGuestPageState createState() => _TimeManagerGuestPageState();
}

class _TimeManagerGuestPageState extends State<TimeManagerGuestPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Center(child: Text("Please login first"))));
  }
}
