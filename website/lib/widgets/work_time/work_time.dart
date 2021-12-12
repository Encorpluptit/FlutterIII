import 'package:flutter/material.dart';

class WorkTime extends StatefulWidget {
  WorkTime({Key? key}) : super(key: key);

  @override
  _WorkTime createState() => _WorkTime();
}

class _WorkTime extends State<WorkTime> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('Entry A')),
    );
  }
}
