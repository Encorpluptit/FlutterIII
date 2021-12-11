import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeManagerErrorPage extends StatefulWidget {
  final String error;
  const TimeManagerErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  _TimeManagerErrorPageState createState() => _TimeManagerErrorPageState();
}

class _TimeManagerErrorPageState extends State<TimeManagerErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Center(child: Text(widget.error))));
  }
}
