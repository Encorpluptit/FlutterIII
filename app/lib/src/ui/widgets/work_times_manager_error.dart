import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkTimesManagerErrorPage extends StatefulWidget {
  final String error;
  const WorkTimesManagerErrorPage({Key? key, required this.error})
      : super(key: key);

  @override
  _WorkTimesManagerErrorPageState createState() =>
      _WorkTimesManagerErrorPageState();
}

class _WorkTimesManagerErrorPageState extends State<WorkTimesManagerErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Center(child: Text(widget.error))));
  }
}
