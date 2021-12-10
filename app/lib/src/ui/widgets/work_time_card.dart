import 'package:flutter/material.dart';
import 'package:timetracking/src/models/work_time.dart';

class WorkTimeCard extends StatelessWidget {
  final WorkTime workTime;
  const WorkTimeCard({Key? key, required this.workTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Ink(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            top: BorderSide(width: 2.5, color: Colors.grey),
            bottom: BorderSide(width: 2.5, color: Colors.grey),
            left: BorderSide(width: 2.5, color: Colors.grey),
            right: BorderSide(width: 2.5, color: Colors.grey),
          ),
        ),
        child: const InkWell(
          customBorder: CircleBorder(),
          // child: Center(
          //   child: Text(textValue, style: textStyle),
          // ),
          // splashColor: splashColor,
        ),
      ),
    ));
  }
}
